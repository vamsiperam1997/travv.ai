# Travv Website - Deployment Guide

## Files Included
- `index.html` - Main landing page with app store links
- `privacy-policy.html` - Privacy policy page
- `styles.css` - Complete stylesheet for both pages
- `travv_logo.PNG` - Your Travv logo

## How to Add Your App Store Links

Before uploading to AWS, update the store links in `index.html`:

1. Open `index.html` in a text editor
2. Find these two lines near the bottom of the file (around line 212-213):
   ```javascript
   const googlePlayUrl = 'YOUR_GOOGLE_PLAY_LINK';
   const appStoreUrl = 'YOUR_APP_STORE_LINK';
   ```
3. Replace with your actual links:
   ```javascript
   const googlePlayUrl = 'https://play.google.com/store/apps/details?id=your.app.id';
   const appStoreUrl = 'https://apps.apple.com/app/your-app-id';
   ```

## Deployment to AWS S3 (Static Website Hosting)

### Option 1: Using AWS Console

1. **Create an S3 Bucket:**
   - Go to AWS S3 Console
   - Click "Create bucket"
   - Enter bucket name (e.g., `travv-website`)
   - Choose your region
   - Uncheck "Block all public access"
   - Create bucket

2. **Upload Files:**
   - Select your bucket
   - Click "Upload"
   - Add all 4 files (index.html, privacy-policy.html, styles.css, travv_logo.PNG)
   - Click "Upload"

3. **Enable Static Website Hosting:**
   - Go to bucket Properties
   - Scroll to "Static website hosting"
   - Click "Edit"
   - Enable static website hosting
   - Index document: `index.html`
   - Error document: `index.html` (optional)
   - Save changes

4. **Set Bucket Policy:**
   - Go to bucket Permissions
   - Click "Bucket Policy"
   - Add this policy (replace `YOUR-BUCKET-NAME`):
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Sid": "PublicReadGetObject",
         "Effect": "Allow",
         "Principal": "*",
         "Action": "s3:GetObject",
         "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
       }
     ]
   }
   ```
   - Save changes

5. **Access Your Website:**
   - Go back to Properties > Static website hosting
   - Copy the "Bucket website endpoint" URL
   - Your website is now live!

### Option 2: Using AWS CLI

```bash
# Create bucket
aws s3 mb s3://travv-website

# Upload files
aws s3 cp index.html s3://travv-website/
aws s3 cp privacy-policy.html s3://travv-website/
aws s3 cp styles.css s3://travv-website/
aws s3 cp travv_logo.PNG s3://travv-website/

# Enable website hosting
aws s3 website s3://travv-website --index-document index.html

# Set public read policy
aws s3api put-bucket-policy --bucket travv-website --policy '{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadGetObject",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::travv-website/*"
  }]
}'
```

## Using CloudFront (Optional - for HTTPS and better performance)

1. **Create CloudFront Distribution:**
   - Go to CloudFront Console
   - Click "Create Distribution"
   - Origin domain: Select your S3 bucket
   - Origin access: Public
   - Viewer protocol policy: Redirect HTTP to HTTPS
   - Default root object: `index.html`
   - Create distribution

2. **Wait for deployment** (15-20 minutes)

3. **Access via CloudFront URL** (you'll get a URL like `d123456abcdef.cloudfront.net`)

## Adding a Custom Domain (Optional)

1. Register domain in Route 53 or your domain provider
2. In CloudFront, add your domain as "Alternate domain name (CNAME)"
3. Request SSL certificate in AWS Certificate Manager
4. Create Route 53 record pointing to CloudFront distribution

## Features of the Website

✅ **Responsive Design** - Works on all devices (desktop, tablet, mobile)
✅ **Modern UI** - Clean, professional design with smooth animations
✅ **SEO Optimized** - Proper meta tags and semantic HTML
✅ **Fast Loading** - Optimized CSS and minimal dependencies
✅ **Interactive Elements** - Hover effects, smooth scrolling, animated components
✅ **App Store Buttons** - Clickable buttons for Google Play and App Store
✅ **Privacy Policy** - Complete, professional privacy policy page

## Support

For any issues or questions, contact: vamsinagaraju1997@gmail.com

---

**Note:** The website uses Google Fonts (Outfit and Space Mono). Make sure your users have internet access for fonts to load properly, or download and host the fonts yourself for offline use.
