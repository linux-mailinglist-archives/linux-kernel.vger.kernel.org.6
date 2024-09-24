Return-Path: <linux-kernel+bounces-336846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942649841AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81EC1C23FF5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA4154BE2;
	Tue, 24 Sep 2024 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzhVeyxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD4153812;
	Tue, 24 Sep 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169061; cv=none; b=UA8mihi/ipo0mE1Tjid8tXZKXj87kNw0aFIR8DRnjOGikLkQ54dkIs/c9ahbKmrIXXh8gEx+NWELcKQR0lHy1vjcUUCL90zGpvW5wMYOJvoGm8ksyysjR+EJj8WBP3hdLyW6vks8yVU2MmYjEbWBwqvqjJx0pxl3G0kORFpf3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169061; c=relaxed/simple;
	bh=sXMMD2yX79PYZrB+sJMUAHiomRdmGg07qqsS7xZ1bUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgcVY8cu5aP3aK9DZ0plr/7WuhPWgbCcMVo0fFPHAh7RJZCEdkahVY0VmBlVktGzcQRxZIKUrrViT+J50q690c8kYr9wWLmrPBrBnGaF2SgA1Jk83xZbpthMVOdW77cz+7OwtUJdIsdHfmd1H/MEdS83V0cUvZCtLG+Fu827cXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzhVeyxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C93DC4CEC4;
	Tue, 24 Sep 2024 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169060;
	bh=sXMMD2yX79PYZrB+sJMUAHiomRdmGg07qqsS7xZ1bUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzhVeyxGkxWspN6515ahE38RxEshnjolvVTBkPBSXX8/oebyfBm/Vb5Ctut+/pnnk
	 7zqyrqiZSK2+3nPvw7YCkCI1qUhJo7Udah+cT67nZjh7LyyJ5nHzweMu2F9HHnrBBw
	 x8UvM4wUHNcyYNXb45sR+wukmAjgZ/ejBo/ppSLEv9C/PcoNSQG2JmevzVfkz16A8+
	 +Ha6ePPjCAULdJFKfRMyHRxn8sZGZWCHowAk12soo5frE33orKGMxesuXLa+1Of68P
	 SiR8mR3eNoOjUtq0bDHwMyQBoqU+XNOsZqMQzPhznTw4sNKy01CUWRovLQS1+KKs8q
	 Z1uhuiUnJRx4g==
Date: Tue, 24 Sep 2024 11:10:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, krzk+dt@kernel.org, ck.hu@mediatek.com, 
	robh@kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: mediatek: dpi: Add power
 domain for MT8195 DP_INTF
Message-ID: <xtugchpbl6ad73v4cthrgv4brn7ochy5rp2iipmkguhwdjo4d7@aognbiq4wcet>
References: <20240919112152.2829765-1-rohiagar@chromium.org>
 <20240919112152.2829765-3-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919112152.2829765-3-rohiagar@chromium.org>

On Thu, Sep 19, 2024 at 11:21:52AM +0000, Rohit Agarwal wrote:
> Add power domain binding for MT8195 DP_INTF that resolves the following
> error and many more similar ones:

Binding is already there. You do not add anything new here. Please
describe what exactly you are doing in terms of hardware? Do you have
power domains or not?

> 
> arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000:
> power-domains: False schema does not allow [[55, 18]]

Best regards,
Krzysztof


