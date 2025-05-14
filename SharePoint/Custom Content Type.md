# Custom Content Type

This procedure goes over the steps required to create and add a custom content type to a SharePoint site.

## Requirements

You will need to be "SharePoint Administrator" in order to make the following changes.

## Nomenclature

Content Type : Type which you can assign to a site's content, which defines which properties are associated with it.

Term Store : Repository containing the term groups used for defining custom metadata in content types.

Term Groups : Grouping of Term sets. Used for classifying and categorizing term sets.

Term Sets : List of terms that can be referenced in a custom content type's properties.

## Setting up term groups

Access the global term store by editing the following URL :

```txt
https://<Your Tenant Name>.sharepoint.com/sites/contentTypeHub/_layouts/15/SiteAdmin.aspx#/termStoreAdminCenter
```

In the "Global term group" use the "Add term group" button in order to create and name your new term group.  
You can use existing term groups if you already have a defined structure.

Once you created the term group, create a term set. As a reminder, a term set is a global term which groups the lowest category for your new content type.  
Add the various terms used to define and/or classify your content type.

## Creating a content type

It is generally recommended to create a content type by using a pre-existing contents type as a template.

Find the content type you want to use as a template and document the following:

- Category
- Parent

Next, click the "Create content type" button and use the data documented in the late step in order to populate the "Parent content type" information.  
For the category, we recommend you create a new one in order to more easily distinguish them.  
If you already have one, you can reuse it.

## Adding columns to you content type

Open you newly created content type and choose:

- Add site column
- Create new site column

Next fill in the name of the column, a description of its contents.  

### Using custom term sets

Fill in the following:

- Category :
    [x] Use and existing category
    [ ] Create a new category