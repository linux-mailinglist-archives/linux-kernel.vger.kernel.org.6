Return-Path: <linux-kernel+bounces-406760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C89C6589
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9498B37261
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E921A4B7;
	Tue, 12 Nov 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rbIGvKjM"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0E20BB59
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447412; cv=none; b=mK1J5fzuM+mxzIP/iiVHKCSlEzMkgBTfun035pfPH//JWXPI1oxZFmjGpZW8xa2qyfzsdW2kICNDb20kPYR4GRrYphp6cjIkwJ030QCi0orJj8q7VZ71aoe1iGVH47jlfS2qYLC5gmBo9+/ogZ4VAZ8M6yNq7nByS8rVcEhTEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447412; c=relaxed/simple;
	bh=FUaGaLT2vWhcvKmrRmnWQ6yznG0eYBTKSj5Gr3snUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL1TwMfj8BmhmCCGCr5Jafj/buO9/MM8D8rvBi9nA7XhENVILFTZ/wgp1xvO4gkWsKkYBIBQapKb5p9L+0QnjT4sFqmXvYiLTtLX07aMDvK+RwJ7MVfJqfqyC/Aw+fo1R0S3a4Pbpz2TaQGUQJEKMjoewvrewMo2/s7LL6UqC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rbIGvKjM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=xvZQ89U7d8pC8lQzN0FHCMGQlK0WYWABLk8PU80D3Hg=; b=rbIGvKjMUMGtVPRS
	IMbQBWKsnBxA8u3fXZpGFSC0oGt+ofH/4oUED8Ge9j9p0sjugYkmpvFhwi64FsaaRXHVi7yJdYsOK
	pG27Tk4EfUG3o7gxCemEX5hjiQ5KtXVt/ImOfz0iu8IFKCvGmMeqJTLyYSQ+pbb6uwg/yHmhCr8OT
	ysy2/OW3OEfcUx+Kcp/NsYQGuFTez9q7X4LC7adi7YEE1py7Lhz+X+aBZz19gFJJ0QTn3FH9BXv1W
	tGSWQPYSkK9nwlqAB75ENeppeepIgpFYu7yPRiPwOzuWa4Rx1vmvptNCw4rItgqx4+Dlg4n67ziON
	yY6L4UEbd+mMvvwOiA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tAyZ3-00H8oV-1y;
	Tue, 12 Nov 2024 21:36:45 +0000
Date: Tue, 12 Nov 2024 21:36:45 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jlbec@evilplan.org, hch@lst.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: Remove unused configfs_hash_and_remove
Message-ID: <ZzPKbY3n9gxHebJl@gallifrey>
References: <20241010205655.278385-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241010205655.278385-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 21:36:33 up 188 days,  8:50,  1 user,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> configfs_hash_and_remove() has been unused since it was added in 2005
> by commit
> 7063fbf22611 ("[PATCH] configfs: User-driven configuration filesystem")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

Thanks,

Dave

> ---
>  fs/configfs/configfs_internal.h |  2 --
>  fs/configfs/inode.c             | 25 -------------------------
>  2 files changed, 27 deletions(-)
> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index e710a1782382..5c20e83315bc 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -73,8 +73,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
>  				void *, umode_t, int, struct configfs_fragment *);
>  extern int configfs_dirent_is_ready(struct configfs_dirent *);
>  
> -extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
> -
>  extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
>  extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
>  extern int configfs_setattr(struct mnt_idmap *idmap,
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index dcc22f593e43..1d2e3a5738d1 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -216,28 +216,3 @@ void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
>  			spin_unlock(&dentry->d_lock);
>  	}
>  }
> -
> -void configfs_hash_and_remove(struct dentry * dir, const char * name)
> -{
> -	struct configfs_dirent * sd;
> -	struct configfs_dirent * parent_sd = dir->d_fsdata;
> -
> -	if (d_really_is_negative(dir))
> -		/* no inode means this hasn't been made visible yet */
> -		return;
> -
> -	inode_lock(d_inode(dir));
> -	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> -		if (!sd->s_element)
> -			continue;
> -		if (!strcmp(configfs_get_name(sd), name)) {
> -			spin_lock(&configfs_dirent_lock);
> -			list_del_init(&sd->s_sibling);
> -			spin_unlock(&configfs_dirent_lock);
> -			configfs_drop_dentry(sd, dir);
> -			configfs_put(sd);
> -			break;
> -		}
> -	}
> -	inode_unlock(d_inode(dir));
> -}
> -- 
> 2.47.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

