Return-Path: <linux-kernel+bounces-221807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5190F8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13C3284307
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6981749;
	Wed, 19 Jun 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urNDuDLu"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038784654D;
	Wed, 19 Jun 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718835401; cv=none; b=nXkoZCW5WWb8cohZZ0PsPkp0k+ieexxxCB9MnqaAB/N5m//7W1+8v1APGWjO97/A7BAK9He2IFebnz5Ct4SOrytjt6gq04XdHZ0IsfQsryzfFacfvEbkx9OQ62PrwlrM62N/QJw4+swedoa3TL/Wi74gBZytAEG32E+Do77fNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718835401; c=relaxed/simple;
	bh=Y0+UaBVks4XD+mPAwSKc+6MW09nYjcjhu5D+T2hL+VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YnfbOCOg2hqxm7N+OXqjAmDcdqOcxPmX28sZ5UIJxn73vtuUsXAJYSaM/LePXe/vWeu2adLhMfXrN7P8V3JdJt+Cou4XJnBBoqPyH7rxUcG7xAB4FHZAIvrErvZ+104KHu8g2eKdEMiF13Me0Yznd8FxDQrX0Aag5Y5worxLCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=urNDuDLu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=Mf1SCXQnbCaHNlux7nlkNp1wRU6GF0j6mup783iWpdk=; b=urNDuDLuwwnmlCpwNxjae6dSAz
	mx6H64Q8+XX0+zOxBrCeYW+kn5aPzgbeHXV6oNxPuoFQskNM/y1xX7x2frEPuroDbUBPNJIdmnueG
	uvoRgXJogfsYIUYombIJRAoD4yiVnIKSV7BSlqca7mJzRz25eVA3cF/Ev+9RcI897lZtTzhHWF1ST
	4DMKa2szVuTjVxqeH2vqVtwLWfPXPxqlkI0XcIJh9cAz2wzodeQXsR0+8tPAm/Sup7XiYJhM6OP7q
	1OcZYddF9bd5hYk2ViT7+4p4BOBEPplNBEuwCmRClsvvI1/PxG7XLOocg6BoKU2cp4I/UhznIgPJz
	+1cZWQAQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK3bb-00000002r7i-1sv9;
	Wed, 19 Jun 2024 22:16:39 +0000
Message-ID: <0efb1ef2-2385-452e-ad1c-b4271e8348ae@infradead.org>
Date: Wed, 19 Jun 2024 15:16:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: English corrections in vmalloced kernel
 stacks
To: Nir Lichtman <nir@lichtman.org>, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240619215944.GA3571421@lichtman.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240619215944.GA3571421@lichtman.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/19/24 2:59 PM, Nir Lichtman wrote:
> From 34f137faedf7769b2ab8c834ce57d4de56eb0d88 Mon Sep 17 00:00:00 2001
> From: Nir Lichtman <nir@lichtman.org>
> Date: Thu, 20 Jun 2024 00:45:14 +0300
> Subject: [PATCH] Documentation: English corrections in vmalloced kernel stacks
> 
> Minor grammar fixes in vmalloced-kernel-stacks
> 
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
> ---
>  Documentation/mm/vmalloced-kernel-stacks.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

