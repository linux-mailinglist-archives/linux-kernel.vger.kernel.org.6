Return-Path: <linux-kernel+bounces-231837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E46919EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBA1F23D19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6C208D7;
	Thu, 27 Jun 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="QAMnQuyA"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2751CF92;
	Thu, 27 Jun 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467749; cv=none; b=NYbolFVpwNGT3Wq8xARLm64c32qrtbbofMASqUaB7TglDgWw/yXxdrOP4f1CLUHrC7Qtd6R2zere/Q4qmmKgt1hGXeDJ44ibHEN49vqbBDkZynATT6vRmIagDrd471VjRrqyn/mfjUbCvbuyx+JXsb5XXdsSu4YDJ5+oG9qzh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467749; c=relaxed/simple;
	bh=xOmKMNXZBEG4oHeTtcg85qowauS0P1r2UBuwgImGCuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XykoJcOjbng9TpK4ESjcRaGI9FONMQZySrxKtFGqAO8GPxr6UPOb82VFWPzDjTQS589kD3JyG6EGWhgJ5AYoDmQEcE5rQwVFfsx/PDpdyT4ER4GPuJTHQ4Oh9KMcTZ/K7HI900kwkvUDSNpbWagqsSP76+tM+5LR9MTldKCzv3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=QAMnQuyA; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 48C46176E38; Thu, 27 Jun 2024 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1719467304; bh=xOmKMNXZBEG4oHeTtcg85qowauS0P1r2UBuwgImGCuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAMnQuyAqkYNdiS4cTBN7ITekznek5sm8UKQKbrr0w/zQp7gHxIa3vN80RT61YwGM
	 GxM47QNvOnmctpeiQR0ZrVu9lzIiZ+1rOl08zWNZv9sgEzKbmb9rdhSufZYY9aCWOL
	 sFc7Cj/XYVxazlNfT3kI3ZDsqP7GgnwmoUnCKUCo7aTP4OYL8ruCX0InoBz5CTidGM
	 RgC90HsLiFSISYGvgXJ8fgQ/qEiPNl+rptfWIJD4cKKaRFYKfCllr6/f3ZC8Tit8pU
	 WweZI4BfXauQeXTsc4i5LGzT9oU0lDuz67R6XpqJCbklEb2LM4vVJxUiv4ihrBqkf+
	 DWWZbKlP3/Czw==
Date: Thu, 27 Jun 2024 05:48:24 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: English corrections in vmalloced kernel
 stacks
Message-ID: <20240627054824.GA3723247@lichtman.org>
References: <20240619215944.GA3571421@lichtman.org>
 <87msn7xqf2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msn7xqf2.fsf@trenco.lwn.net>

Noted.

Thanks,
Nir

