Return-Path: <linux-kernel+bounces-267567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C59412E3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E71F24514
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22628199389;
	Tue, 30 Jul 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YgsAvC5W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210922CA7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345402; cv=none; b=Mlz1PjnZexTxmlcM/wg2pYMQ0ZQUnTETShfDzWZ/gsHNK9IuvE9fYhJjGh1pvAOxvosnxA2TQZ2QImn54O+IJwINbtKfRmwyVjY+R95x9e+GbCUUTnbwoRhC7FBIImLp7YZ6689JQn6bgfvEDL/3X6TBAXLACvs1Q+MAAAbPhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345402; c=relaxed/simple;
	bh=KqdWcM5MP7L+cX9udLexDIx4xd68NTvESqR9R08kK8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtntF9Wz4SCIffZTt5gkQ1o3sz/E/1Ix+8NUQWRPlFBIlDtxId79KEJikUtVq/1/PSwwGIZDp288kGcfeAupG3wjg2Xx3+OnRyIFMdWixXBPXfW70cqcKBzFmpJSxVpMWcLn+9Q+oNcyy/g6FB9kFuMi+iYSQHXYuMsE+HG/PwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YgsAvC5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42914C4AF0A;
	Tue, 30 Jul 2024 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722345401;
	bh=KqdWcM5MP7L+cX9udLexDIx4xd68NTvESqR9R08kK8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgsAvC5WE1sNIJo9pwyW15Pa5dG/pT3CEsUkRwUTSXlz0uVufyeFk2ODJHBdbi6RN
	 6s+T4UvwRftmKK+u03P2xqUOma7kGq1bJ5X9jDFG4Nync1c9BLu8wnWaefC9Z8ulmB
	 t99la74Smqj9igCh7H+ThlD9fN94W0wdQJufPAns=
Date: Tue, 30 Jul 2024 15:16:38 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?6IOh6L+e5Yuk?= <hulianqin@vivo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHVzYjog?=
 =?utf-8?Q?gadget=3AFixed_th?= =?utf-8?Q?e?= problem of abnormal function of
 mobile  phone as UVC camera.
Message-ID: <2024073015-cannon-colt-b4e2@gregkh>
References: <TYUPR06MB621753631B9F7836583E7BEED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <2024072537-landowner-diaphragm-1d22@gregkh>
 <TYUPR06MB62176D779EE13F08D6295C3ED2AB2@TYUPR06MB6217.apcprd06.prod.outlook.com>
 <TYUPR06MB621755F6FD643E99DBD21D42D2B02@TYUPR06MB6217.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYUPR06MB621755F6FD643E99DBD21D42D2B02@TYUPR06MB6217.apcprd06.prod.outlook.com>

On Tue, Jul 30, 2024 at 12:14:33PM +0000, 胡连勤 wrote:
> Hello  linux community expert:
> 
>   What other information do we need to provide for this patch to be uploaded?

Please answer the questions and redo the patch based on the review.

And please do not send HTML email, the mailing lists reject it.

thanks,

greg k-h

