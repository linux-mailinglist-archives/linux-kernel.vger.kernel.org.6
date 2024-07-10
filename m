Return-Path: <linux-kernel+bounces-248430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CE92DD13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D51D1C217B5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBD5158A19;
	Wed, 10 Jul 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6YbKyWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E1156968
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655094; cv=none; b=tYOJL5v9ys8nr5GDcaTorYJ7eyDF90ujuye1sbdYvcHaimr0XeclGQUYgXBCHMYl9o3flLOdvkgREEyQ74bc33lw6R6hFnUC5ZvBbsnOGVRg06XRBxBph+vYqh/zNlaB8o34P6Vt/iNyht1c5N3OggKAsUe0MkZQXr2xzlEtUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655094; c=relaxed/simple;
	bh=RlU5qdZXTV2dF3NT+nL4H3tIUBMv0nZjJ1Ispw7bS6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=atFf0zx2wWk+gqm/KUhi5vE/a1O14MuLrm4h4Yy0OugAAEd00GZndPIsTteJ+NtA7yZcDiCxpxqt59YBsEQgS26zHnTgZXK7Qoz0RtCZ4ZlQvw5h2Eqb9RZd91eQuCuxTewIwerP/4WPXd2R5uxQl+3pPy4rTPEdE63GMB0+x4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6YbKyWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EDBC4AF07;
	Wed, 10 Jul 2024 23:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720655093;
	bh=RlU5qdZXTV2dF3NT+nL4H3tIUBMv0nZjJ1Ispw7bS6U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=G6YbKyWzszMGepScRgEHNrHj4Nrv0oyNXTCGShHa77bwVmwpJI7vjRSUFrrPacN12
	 8CZOzXmkvQNk3AJCb99Rwak5fWrbTMtoMdjtTCjg8IVKFOngrpPxlMXQo2LEboZgVv
	 +nFLyCB2zkce60ihkxKy3pOCR//2FO/VFJTrWf+BIdAfu5I3bF/WeZslOJrI1wbhIS
	 5QDk+pqq3oUifuX0LVFxj8tuKBg/jqFa9H/MYwYelktbmVvl233cR5EPPlzYIZkJCV
	 puJDz86RvqGrxlxYzefoYOt+PGWevFjooB5q/hFUjMyu0sJj/hGoHpxw3PYDXUGO1x
	 K6E92DY0MNMRg==
Date: Wed, 10 Jul 2024 16:44:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Chen Ni <nichen@iscas.ac.cn>
cc: sstabellini@kernel.org, linux@armlinux.org.uk, 
    xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/arm: Convert comma to semicolon
In-Reply-To: <20240710014208.1719662-1-nichen@iscas.ac.cn>
Message-ID: <alpine.DEB.2.22.394.2407101643290.3635@ubuntu-linux-20-04-desktop>
References: <20240710014208.1719662-1-nichen@iscas.ac.cn>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  arch/arm/xen/p2m.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
> index 309648c17f48..9da57a5b81c7 100644
> --- a/arch/arm/xen/p2m.c
> +++ b/arch/arm/xen/p2m.c
> @@ -109,7 +109,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
>  		 * immediate unmapping.
>  		 */
>  		map_ops[i].status = GNTST_general_error;
> -		unmap.host_addr = map_ops[i].host_addr,
> +		unmap.host_addr = map_ops[i].host_addr;
>  		unmap.handle = map_ops[i].handle;
>  		map_ops[i].handle = INVALID_GRANT_HANDLE;
>  		if (map_ops[i].flags & GNTMAP_device_map)
> -- 
> 2.25.1
> 

