Return-Path: <linux-kernel+bounces-191698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5A8D12C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF4280E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE87013BC3A;
	Tue, 28 May 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8YTMGPr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB318EA2;
	Tue, 28 May 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716867179; cv=none; b=Ca7y4Yf8R2JWmE+5hGc2/31U6DGZUBFYIt5N56KxZ56ZPIgarlL7FiYy6d14jRRGwwF7JuXH4zbk6LDTvbE/5B9//ZCIGCG+2kFK+4IS4qOmG5Be3iNuii00JRkvpVu3TeRbB+QPxjL/W55ddLRi9qg1MuxLi+ExbuS1KQ17X/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716867179; c=relaxed/simple;
	bh=53Zoo0TuTvasbIJ4R/5kxbQ7OqUI4K3hEKG1JuahvXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRGsFGyXE11QKOFRiplcmvlOVviuDOR6Z6UmqCWZ+VGgcvc7AZUJeXfmAFvvieNbEARbYll0Gco7ihxH7rofit5RT9Jmy1kXPGIFyhfbf7u5GEwrJc5ZJIvxPjODYtVWfFOe/zKJsKcowiavxkHirlhiiMwHsLodSEyTUlSDlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8YTMGPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C251DC4AF0C;
	Tue, 28 May 2024 03:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716867178;
	bh=53Zoo0TuTvasbIJ4R/5kxbQ7OqUI4K3hEKG1JuahvXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8YTMGPreyKZdWkW7R6ul+FCpfpFYGgwHlnD74oFX6xnHq79UfUdhruNxyk/T1Bqj
	 h+d3Znhrom0mZuz+6n+3/N6HYXoOhG1YuN6GlLBUEUCP0MCtBKOiaJHQwxKPFZTJ/o
	 0VEmcyRWfXCpd++hnBm7keTm9UwkqGjAuG7Ii+K281eiixWhHITJcyuWIXkJBhpi2v
	 JQOn9Oaa+SJK/F0x7pkP8orN3TPu8bEppYBsppSQ6sWMVucB7MiGPoLYAtGsWxByar
	 2fBSHktJPxkMC3/xFknpyD87yVddetZiJwKhXdcld6OKYerJJje4M0+idbTKFs16nk
	 cr6Jc22+7UEHQ==
From: Bjorn Andersson <andersson@kernel.org>
To: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adam Honse <calcprogrammer1@gmail.com>,
	Luca Weiss <luca@z3ntu.xyz>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/2] Add Samsung Galaxy Note 3 support
Date: Mon, 27 May 2024 22:32:20 -0500
Message-ID: <171686715168.523693.5892166453398806176.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
References: <20240314-samsung-hlte-v2-0-84094b41c033@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Mar 2024 20:00:13 +0100, Luca Weiss wrote:
> Add the dts for "hlte" which is a phablet from 2013.
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom: msm8974: Add Samsung Galaxy Note 3
      commit: b4f6c63bf34d8da1b769483bb1f4a603c53896ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

