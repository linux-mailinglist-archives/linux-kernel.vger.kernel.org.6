Return-Path: <linux-kernel+bounces-274354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B394771E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BF81F21B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CFD14D71A;
	Mon,  5 Aug 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Fy+lyfE/"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C952A8FE;
	Mon,  5 Aug 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846226; cv=none; b=gD+zr0fExXa0DbA1CINLxvHxeEf22f0PEGoYFElDPjIKTi/4XCaqrXW/zqvvtZiS1bNV/PBI1gtGoncWDvQ2kxpnvbfTNBWPbJZNxpUPjn34tArTmlAOFGa2ndnIXh1BPR+zn+BNkSeSA/RL9UGCNHffgo2f1mTuoo4tJWFbPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846226; c=relaxed/simple;
	bh=CBVv5Ck7ZSi9ziHAQA0CctDToS083nXpIdJISZf4IPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy+PIdaSfV1+1eq1zWpMEknvBy7FgDjdrStADogFMpdl1HqpfmkOQCVqEcvxTgxaWMn3cmSQq4npy85x60MD9PUmN1MixTN7tpvnyHh8Eqg4IwlPo4AGy9VwloBLntXUzaSvIM1PACM31544du3NoFhjFdObZkN/CcIWB1eNsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Fy+lyfE/; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=lY0J5lxlDggedNSZjkWUH/IK1tES9nnaPHIF4eKoQaA=;
	b=Fy+lyfE/20DjqjJ1LPnOgWGVfBIZTIQjfpRmvKUUjumzitcT8oo4UxWt1zMbdj
	AfdqnJmzAL5wUIwu7hp82C8VX0IIsJiL9z1ARm7XmgCUPjHFMU3rSJLMOEmcv6DS
	EhWNgh5Do9k4JzPpQsaP1AqxkC+W2SeFGkAZyqm8RzoVA=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnr5Tti7Bmy7PVAQ--.64715S3;
	Mon, 05 Aug 2024 16:23:11 +0800 (CST)
Date: Mon, 5 Aug 2024 16:23:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: layerscape: fix thermal node names length
Message-ID: <ZrCL7YfS3NQ306za@dragon>
References: <20240702145417.47423-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702145417.47423-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Ms8vCgCnr5Tti7Bmy7PVAQ--.64715S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1rZFyUCFW5KF1UXF18Krg_yoWxtwb_JF
	nxJw12gwn7uwnxtr4xJF1ku3s5KrWqgF15JF4F9rWrX3s0qFWDX3y3G34Sq3y8Xrs09rsr
	GFy8KrZ3uw13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU04KZPUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAwyZWawgQMoFQAAs2

On Tue, Jul 02, 2024 at 04:54:17PM +0200, Krzysztof Kozlowski wrote:
> Linux kernel expects thermal zone node names to be maximum of 19
> characters (see THERMAL_NAME_LENGTH, including terminating NUL byte) and
> bindings/dtbs_check points that:
> 
>   fsl-ls2088a-rdb.dtb: thermal-zones: 'core-cluster1-thermal', 'core-cluster2-thermal', 'core-cluster3-thermal', 'core-cluster4-thermal'
>     do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
> 
> Name longer than 19 characters leads to driver probe errors when
> registering such thermal zone.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!


