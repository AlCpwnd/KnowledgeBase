# KnowledgeBase
Random Collection of knowledge

---
## Windows
- [[DISM Offline Repair]]
- 
### Stand-Alone DC DFS Replication Error (Event ID 4012)
> [Source](https://www.mcbsys.com/blog/2018/12/dfsr-error-4012-on-stand-alone-domain-controller/)

1. Run CMD as admin
2. Run `net stop DFSR`
3. Open ADSIEDIT and navigate to: "You domain"\Domain Controllers\"Your DC"\DFSR-LocalSettings\Domain System Volume
4. Open SYSVOL Subscriptions properties and edit the following:

   msDFSR-Enabled=FALSE  
   msDFSR-options=1  
5. Run `net start DFSR`
6. Rerturn to the same location as in Stop 4 and edit the following:

   msDFSR-Enabled=TRUE  
7. Run `repadmin /syncall /Adp`
8. Run `DFSRDIAG POLLAD`
