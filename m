Return-Path: <linux-kernel+bounces-340807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96498987819
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54471C229EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A963156256;
	Thu, 26 Sep 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jvXZOjna"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE862837F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370230; cv=none; b=OlWMpSAf1K5XGRHBholiWqBuL+HJf8DLpncv7hNvL57iqwx4qKh+gQVBLeAJ7w1bmzkDYWhKLwscnO4CFFD5YG8FlR2PiI1nVcoameqicvy70axP+y+oE1CZuaWbpYRfTgcrIfRpflWceHxcuWdMCyLQ4trSdgkm0WR4OKKIwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370230; c=relaxed/simple;
	bh=OBoKePxH3htZOG0WIkgYaNUo3NSB8MVlaQmbkBg3A4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxuVR1B9/NU59omZUzCtBzcQd/YaRUqCBejLibr6wQVn/Nuqzb4/0rBjrldTyOffGw+n0yu76ZFwf1pFeRAwgTv8jW9kn4lTt+4kExuoSvL+kg/XgMgt5MPNMQ50CvtLgig5MDGBYc97xiBll3ub6sa74k95sUj99J+XV/j0pfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jvXZOjna; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=FJ28yejPmL4fLTTLu5i990SoLAP/8mJb1/3sWFI2/PU=; b=jvXZOjnaVheJAPeMYKdObR90d6
	26DJxAF727n1kobjKO+ofDudLnbc/xXtarWbyFHxAafrDVe/s99+ctvHp2cfX8Q59+sRIQbp1Vh1v
	kRFIZ7j1ea/8xWOgPsiocySywvp+UcWEI9xFt/WFL1Ln7EKsRxfueGMqt7CYVpWvTzf4bOY1xv3yh
	isEHp1eJjO7I2NGGHqQTC4rwvnG1UWEZJmrGGlbjTo8z0mAszPTIG93aFp38GFwCPo7xhBNJbZ3PY
	QIhCaQBmFRu+uK4C+IQv+YMu0GtxgfVN0lm2mWceKnq75qy2KDuytIci8F/pCQK6VeQ9eGpfV0AOv
	51wAg4vg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1stru5-000000079XG-3VwU;
	Thu, 26 Sep 2024 17:03:46 +0000
Message-ID: <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
Date: Thu, 26 Sep 2024 10:03:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon
 library
To: Zhang Boyang <zhangboyang.id@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240924123141.16962-1-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/24 5:31 AM, Zhang Boyang wrote:
> Hello,
> 
> I have made several bug fixes and improvements to reed-solomon library.
> 
> There seems to be no maintainers for reed-solomon library, so I have to send this patch series directly to Linus Torvalds.

Hi,

If I were making this patch series, I would send it to Andrew Morton,
but if Linus takes it, I'm certainly OK with that.

Thanks.

> p.s. Revival of https://lore.kernel.org/all/20220806162510.157196-1-zhangboyang.id@gmail.com/

