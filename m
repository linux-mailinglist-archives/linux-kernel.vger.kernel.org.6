Return-Path: <linux-kernel+bounces-325065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3497546F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ECD1C20F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D38192B61;
	Wed, 11 Sep 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CU0JyAfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81961885B0;
	Wed, 11 Sep 2024 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062507; cv=none; b=eJi4VPBlDYhUOeZSSBGFleNur4diriNQKoPSj/ToKFjcsp2DPfxpbnlA9+VCgWc6kiJiSiz7ANyyj490csJ73ehRxQ/JQqDl82lv72lDTf/chL95Cyiwx/98bJM33twgdaGl0yNiAW2bfKx+oIB0sPRRJgFFpAGkSTDAZ5kb/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062507; c=relaxed/simple;
	bh=uh6LHxig3a+PGw/odr//OTWW44M+/SfCRW//EmzuxDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cchk0b6QUs74GNo0lgblwwRYpWacRMtkwsd5M8CVX6+nFbE6yd++qTmWuyz7A3yR4UYA4I5YC1tbbRTKNGpZNnS4gQn7jJvgJmLyGm/+4KhcjsGqlzW22NQ++g3mDaDKUglaEUesMzxSfQhT+V8OJkQMha0g0ipiKMwKeEhNDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CU0JyAfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB497C4CEC0;
	Wed, 11 Sep 2024 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726062506;
	bh=uh6LHxig3a+PGw/odr//OTWW44M+/SfCRW//EmzuxDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU0JyAfRvLslWOXmzg5A9fs3ICIj4mLMLr6UO9Q0QiAzTizPcOTceYXHADkBc631x
	 doJ5CEUbiX029D54ECpH1sQDVm1ixA1x5/j+kJs1dCgAl7BwPLL2mlM7i70QJ5nK9D
	 E9cbZCiFWrv6YQ6iAcA659/+QsQH4PJ1GMnheke4=
Date: Wed, 11 Sep 2024 15:48:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: abid-sayyad <sayyad.abid16@gmail.com>
Cc: linux-staging@lists.linux.dev, philipp.g.hortmann@gmail.com,
	guilherme@puida.xyz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs:  Fix indenation and coding style
 issues in rtw_securtiy.h
Message-ID: <2024091111-cheese-refuse-9b8b@gregkh>
References: <20240911133549.2664372-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911133549.2664372-1-sayyad.abid16@gmail.com>

On Wed, Sep 11, 2024 at 07:05:50PM +0530, abid-sayyad wrote:
> This patch improves the code readability and improves the presentation
> makes it look less scattered.
> 
> Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>

Please use your name, not your email alias.

thanks,

greg k-h

