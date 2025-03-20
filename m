Return-Path: <linux-kernel+bounces-569076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D7A69E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537BF7B012C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E241EA7EB;
	Thu, 20 Mar 2025 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW0iqYGr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA18192B82;
	Thu, 20 Mar 2025 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437564; cv=none; b=pVc0xX1LMEBecajsJh0k25IbODWdEoXuzzgQrCj/QO9N7MfXUH7OkMOgK2gKlBRHB72N5UDwPHPvVoa5AkA9Kr8S0y5mKcTdevweT4M9g4HnU4ejnKGAMQ6X5mYEgk8JjFLriRw1Gtf9dJLkGQvs7cj01yzmKcGEgRx8uG1AVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437564; c=relaxed/simple;
	bh=wd4bDV3Pbt8B3W9w906X2pNdOFxkfrKKq9cy9tqyocI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMKzy1VPdH0XBaAXO/why94aioOMipU3yJN0p6d5hFqoY+F7npT+SU2EJfbKCuUu5CfarQ6yFoFshbxGrxeJAL8duU6nAkqZYwyxGpvOFS5MrfExflNK59OEcthTG6u6qF2Q5+4YN8O0rLvzykEjDUMTQqcdG7NJl2syX1pn9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW0iqYGr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E863C4CEE4;
	Thu, 20 Mar 2025 02:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742437563;
	bh=wd4bDV3Pbt8B3W9w906X2pNdOFxkfrKKq9cy9tqyocI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW0iqYGr9u018xkh9A+wagJOm0WjRvlK8XZjDMnPzm7eFCXN/lkzjOH3lxtTQQCPR
	 KPluGt7UgPwguLuAJmccnFOjURi4XuYP8Au49RM8AdV99eePCDj15xIPRK1OmeAbaK
	 4KYVoFL45mkH/znPMB+2kJg9ww8qMcHS6uZ0lp1hwIn7Xi4p5AW6tVvRFKdIe900h9
	 sBUNUOCF+G4kKP5lBe7QHINoArAa1yYiSxqJrDhE8/3VNdyzkRhfU1NVTggOIjKN8T
	 AUZ5ZwJ+s0mt6U7OaMIz4n6uEE8Hgimv4moGsFN332LTOhn7+UBHBHx+htarvt+gC2
	 dq0jr92Ej7xEg==
Date: Thu, 20 Mar 2025 02:26:01 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] f2fs: remove redundant assignment to variable err
Message-ID: <Z9t8uTQOmVB4ue2B@google.com>
References: <20250319113011.791319-1-colin.i.king@gmail.com>
 <a9c06462-5fd2-4724-9d44-0285f281ecec@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c06462-5fd2-4724-9d44-0285f281ecec@stanley.mountain>

On 03/19, Dan Carpenter wrote:
> On Wed, Mar 19, 2025 at 11:30:10AM +0000, Colin Ian King wrote:
> > The variable err is being assigned a value zero and then the following
> > goto page_hit reassigns err a new value. The zero assignment is redundant
> > and can be removed.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  fs/f2fs/node.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 5f15c224bf78..37c76bb19a8c 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1497,7 +1497,6 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
> >  	if (err < 0) {
> >  		goto out_put_err;
> >  	} else if (err == LOCKED_PAGE) {
> > -		err = 0;
> >  		goto page_hit;
> >  	}
> 
> We could remove the curly braces as well.

Applied as below. Thanks.

@@ -1494,12 +1494,10 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
                return folio;

        err = read_node_page(&folio->page, 0);
-       if (err < 0) {
+       if (err < 0)
                goto out_put_err;
-       } else if (err == LOCKED_PAGE) {
-               err = 0;
+       if (err == LOCKED_PAGE)
                goto page_hit;
-       }

        if (parent)
                f2fs_ra_node_pages(parent, start + 1, MAX_RA_NODE);

> 
> regards,
> dan carpenter

