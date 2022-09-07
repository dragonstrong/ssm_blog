package com.blog.lucene;

import com.blog.entity.Blog;
import com.blog.util.DateUtil;
import com.blog.util.StringUtil;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.queryparser.classic.Token;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.web.bind.annotation.PathVariable;
import sun.security.krb5.internal.PAData;


import java.io.StringReader;
import java.nio.file.Paths;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

/**使用lucene对博客进行增删改查*/
public class BlogIndex
{
    private Directory dir=null;
    private String lucenePath="/lucene";


    /**获取对lucene的写入方法*/
    private IndexWriter getWriter() throws Exception
    {
        dir= FSDirectory.open(Paths.get(lucenePath,new String[0]));
        SmartChineseAnalyzer analyzer=new SmartChineseAnalyzer();
        IndexWriterConfig indexWriterConfig=new IndexWriterConfig(analyzer);
        return new IndexWriter(dir,indexWriterConfig);
    }

    /**增加索引*/

    public void addIndex(Blog blog) throws Exception
    {
        IndexWriter writer=getWriter();
        Document document=new Document();
        document.add(new StringField("id",String.valueOf(blog.getId()), Field.Store.YES));
        document.add(new TextField("title",blog.getTitle(), Field.Store.YES));
        document.add(new TextField("releaseDate", DateUtil.formatDate(new Date(),"yyyy-MM-dd"),Field.Store.YES));
        document.add(new TextField("content",blog.getContent(), Field.Store.YES));
        document.add(new TextField("keyWord",blog.getKeyWord(), Field.Store.YES));
        writer.addDocument(document);
        writer.close();
    }

    /**更新索引*/

    public void updateIndex(Blog blog) throws Exception
    {
        IndexWriter writer=getWriter();
        Document document=new Document();
        document.add(new StringField("id",String.valueOf(blog.getId()), Field.Store.YES));
        document.add(new TextField("title",blog.getTitle(), Field.Store.YES));
        document.add(new TextField("releaseDate", DateUtil.formatDate(new Date(),"yyyy-MM-dd"),Field.Store.YES));
        document.add(new TextField("content",blog.getContent(), Field.Store.YES));
        document.add(new TextField("keyWord",blog.getKeyWord(), Field.Store.YES));
        writer.updateDocument(new Term("id",String.valueOf(blog.getId())),document);
        writer.close();
    }

    /**删除索引*/
    public void deleteIndex(String blogId) throws Exception
    {
        IndexWriter writer=getWriter();
        writer.deleteDocuments(new Term[] {new Term("id",blogId)});
        writer.forceMergeDeletes();
        writer.commit();
        writer.close();
    }

    /**搜索索引
     * q:搜索的关键字*/
    public List<Blog> searchBlog(String q) throws Exception
    {

        List<Blog> blogList=new LinkedList<>();

        dir= FSDirectory.open(Paths.get(lucenePath,new String[0]));
        //获取reader
        IndexReader reader= DirectoryReader.open(dir);
        //获取流
        IndexSearcher is=new IndexSearcher(reader);
        //加入查询条件
        BooleanQuery.Builder booleanQuery=new BooleanQuery.Builder();
        SmartChineseAnalyzer analyzer=new SmartChineseAnalyzer();  //支持中文
        //按标题查
        QueryParser parser=new QueryParser("title",analyzer);
        Query query= parser.parse(q);
        //按内容查
        QueryParser parser2=new QueryParser("content",analyzer);
        Query query2=parser.parse(q);
        //按关键字查
        QueryParser parser3=new QueryParser("keyWord",analyzer);
        Query query3=parser.parse(q);

        booleanQuery.add(query, BooleanClause.Occur.SHOULD);  //SHOULD:或者,有就行
        booleanQuery.add(query2, BooleanClause.Occur.SHOULD);
        booleanQuery.add(query3, BooleanClause.Occur.SHOULD);

        //最多返回100条数据
        TopDocs hits=is.search(booleanQuery.build(),100);

        //高亮搜索字
        QueryScorer queryScorer=new QueryScorer(query);
        Fragmenter fragmenter=new SimpleSpanFragmenter(queryScorer);
        //红色加粗
        SimpleHTMLFormatter simpleHTMLFormatter=new SimpleHTMLFormatter("<b><font color='red'>","</font></b>");
        Highlighter highlighter=new Highlighter(simpleHTMLFormatter,queryScorer);
        highlighter.setTextFragmenter(fragmenter);


        //遍历查询结果 放入blogList
        for(ScoreDoc scoreDoc:hits.scoreDocs)
        {
            Document doc=is.doc(scoreDoc.doc);
            Blog blog=new Blog();
            blog.setId(Integer.parseInt(doc.get("id")));
            blog.setReleaseDateStr(doc.get("releaseDate"));
            String title=doc.get("title");
            String content= StringEscapeUtils.escapeHtml(doc.get("content"));
            String keyWord=doc.get("keyWord");

            if(title!=null)
            {
                TokenStream tokenStream=analyzer.tokenStream("title",new StringReader(title));
                String hTitle=highlighter.getBestFragment(tokenStream,title);  //高亮后的title
                if(StringUtil.isEmpty(hTitle))
                    blog.setTitle(title);
                else
                    blog.setTitle(hTitle);
            }

            if(content!=null)
            {
                TokenStream tokenStream=analyzer.tokenStream("content",new StringReader(content));
                String hContent=highlighter.getBestFragment(tokenStream,content);
                if(StringUtil.isEmpty(hContent))
                {
                    if(content.length()<=200)
                        blog.setContent(content);
                    else
                        blog.setContent(content.substring(0,200));
                }
                else
                    blog.setContent(hContent);

            }

            if(keyWord!=null)
            {
                TokenStream tokenStream=analyzer.tokenStream("keyWord",new StringReader(keyWord));
                String hkeyWord=highlighter.getBestFragment(tokenStream,keyWord);
                if(StringUtil.isEmpty(hkeyWord))
                    blog.setKeyWord(keyWord);
                else
                    blog.setKeyWord(hkeyWord);
            }
            blogList.add(blog);
        }

        return blogList;

    }



}
