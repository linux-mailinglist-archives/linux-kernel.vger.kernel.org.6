Return-Path: <linux-kernel+bounces-175063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728038C19BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92801F24043
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096FA12EBD6;
	Thu,  9 May 2024 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ytti0IAp"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0310A0D;
	Thu,  9 May 2024 23:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295944; cv=none; b=P0EhQ/0K6XdT8l89jKdhisSMTt7i+suN8z8T2zUC8lZyLW2LxTFqxJc0ixdfKKtN6it0n60TEVySFvYuVswdRxrZWa3ygT1vzzWp7iqC3IpljD5gjePIiGiDbLYodyAbf2Pic9cqc5fRcoSMWN9UXHO8JcmACggj0+OVeaxpAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295944; c=relaxed/simple;
	bh=YUw/9TrejcOdUAbs+YbKXNlNvEUIzdXI8igb4MJwXK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw4qQOae/9LCiKP5+Cy8s+Guh3/wEoEfLR2RKjgIXKLyiGvL4hXJVOUmF4aKZSO8zTjuFnAj4fCPbx31hu14XM7knRbLh37zJPHoheUunKc8IKN91HGNa8AD2pzLrp6Kio0n4TVV8WEqOV9FYFYxobshGL/JabKwXiSwmvvi+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ytti0IAp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=zhBvkM2pRtzKfgf1EJZsNUnKcLc5sqv4LincK3MYKUA=; b=Ytti0IAph5lylal2
	VzOAXHbU0Z3/DioImRjsxBnWfZ3KJkaVayyw4AC/feSQgDB/44X9LKK8RbdnDLThcgo3PJKdcFVOC
	Caq079TTEtBMSXxSfIrNk5foIAfDjg38SgcqdZFazUipmI2m+z5XNYVXcYwTfzVXa/N2uyIpXrPsN
	1CA7ZgkuIN1CmXERBwoZIYmysCgZzvJAitKddDfiOVPgkFFgOr/IQdFT0/tkgqp5xkXcqMIVpAINH
	sBK5Qp+/DZYJMY+5/K9C60WI9d3eSC3ZYfKL3ogRpAfaSEwzDZgTwp0NSbfkgYyRc8wdtMTEd3lMH
	JBwM5D+29p8V13cYTQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s5CpT-000HC2-2C;
	Thu, 09 May 2024 23:05:35 +0000
Date: Thu, 9 May 2024 23:05:35 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: emilio@elopez.com.ar, mturquette@baylibre.com, wens@csie.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi: Remove unused struct 'gates_data'
Message-ID: <Zj1Wvy--eXMGzLPZ@gallifrey>
References: <20240509001452.204929-1-linux@treblig.org>
 <a12ee2346ef9e00b6fca5dd4fce7de0d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a12ee2346ef9e00b6fca5dd4fce7de0d.sboyd@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:05:20 up 1 day, 10:19,  1 user,  load average: 0.03, 0.03, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Stephen Boyd (sboyd@kernel.org) wrote:
> Quoting linux@treblig.org (2024-05-08 17:14:52)
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > 'gates_data' (and it's associated define) are unused since
> > Commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").
> 
> Lowercase commit please.

V2 sent with just that changed.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

