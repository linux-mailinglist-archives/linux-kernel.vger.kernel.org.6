Return-Path: <linux-kernel+bounces-415420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A491C9D35D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7371F2186A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79C18660C;
	Wed, 20 Nov 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H7bE49V6"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCC118453F;
	Wed, 20 Nov 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092550; cv=none; b=k+T8XpjfQ0CEesQ5XxaliJY6kPRh+60Qc4EyxzejXun50s1YmffLOZZkrTaDAclzItzOD6ySJn2soM3kYZmgnh3gn6ACRbBenO3OafQdYyzGRU7533O4BxZFRS/JF1BnIAeZW2N2OhO1FvUpjX8Mqdz7++ym/iK2tLzghuFsOqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092550; c=relaxed/simple;
	bh=vn1irB+y7LZamUO0R2i1HevhmfCW2aLFzFzakKr4snw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbgisAaotOAWSHPlCL7T5SYgqSZFa7y+kDUnACTVhRcW7v/d5vNDuho4t7mTW5pL9HWlNG/mqF/bWsqL/p68RkfJPFvZf4Krxh/IglReqv1L8CuQDri6tn0X47dTghiHsFK68mB/elf5Iw5vhvuNUyx5ISL44pH8VW6ysozta0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H7bE49V6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XiGqvQZXOG9mMSv9UcdYW51MRDdWtMLGu/Oj4on5axI=; b=H7bE49V6mgpcmtbtrPI6BUQCTf
	cJQ4o5h+gkTUMIaIGiSkXITKHt+gofgbsOlDiUdGap+NVH46Wq6dI9VeTCkGHy7jLMKuEzTPz1wsi
	I3zi+m7oqzDyhpOZAFskqAqjvHJxNZEs06A2HHYI6GKc7S4GCYYohXusfBxiyorQtkv1ec+n+fcd9
	fbj75+tTyoH04X3w7RyLkBIhK7BpTHPoc9G9xWgf/ugD1KtuFD8kqLDbiaLg0hPh+cmMl+orN8SDb
	I+PMAa6bnuWKSHOToWBBXRlj8ULyG70n9j/+PtPEgd6QfV57IKwGXrIzBaGkxRoLDfQaT17LzS65S
	AW44oo6w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44236)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tDgOQ-00058u-1L;
	Wed, 20 Nov 2024 08:49:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tDgON-0006xD-1D;
	Wed, 20 Nov 2024 08:48:55 +0000
Date: Wed, 20 Nov 2024 08:48:55 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Cong Yi <yicong.srfy@foxmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Cong Yi <yicong@kylinos.cn>
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
References: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_9E44A7B2F489B91A12A11C2639C5A4B9F40A@qq.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 20, 2024 at 02:27:53PM +0800, Cong Yi wrote:
> From: Cong Yi <yicong@kylinos.cn>
> 
> After the support of PCS state machine, phylink and pcs two
> unrelated state enum definitions are put together, which brings
> some confusion to code reading.

Hmm, so the definitions being prefixed with "PCS_STATE_" and the
variable being called "pcs_state" isn't enough?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

