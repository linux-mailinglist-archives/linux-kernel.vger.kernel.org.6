Return-Path: <linux-kernel+bounces-555360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8BA5B65F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334BE1892B48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16FA1E2845;
	Tue, 11 Mar 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gHaW1dD8"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990748821;
	Tue, 11 Mar 2025 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741658207; cv=none; b=V1bD/pl+dtyW2YCwYp8voG6TsLjsc/0WYRdZqmlPWD9BY3mnjyuydjP6FuaBZpOyYFyvhV2Z8LUw4tgB1nVszcMnE3qDYJX4jM/Lu306je0yuWUcjj0/Pi+9/yBB668PIdfv5Cwm4j6gKgDqN9SyU+rYCKoeLzOMTw++C2FDYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741658207; c=relaxed/simple;
	bh=inZDaDcOBwO1rrDGJGVN61bhkclNFKs5uix3YzEO+3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGegBFb3obMc/xMoIC2+dI7Psqdln928aDhjp/60MzETDYcHjgkYrgK7eSQPdIc0zjsyCaalZGPAW+62eiXSaTHybIAfHPjN7Ll1L1GfLctCl5hnfAxk0L8oJMeS1+aT0HMJeAllvs+DDG8GAwPxSlaYz1v3jvqZXEOvPXNXNJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gHaW1dD8; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=X8zFqJWahQRYa7ooRRKZAoytsqOvdRBD6lYtjCz5PvU=;
	b=gHaW1dD8mxc/0Dcexj//CceELvKJ24O37TYm84942lK1bZIQ8oTx70PXyiM7kd
	5qjmaWtu9QHa88ycjdMIBgKJ63s4PJ7epivfDnaFWTk74ZAo3rtuZ7zAoaj/276P
	A3AJD1B8K5H9t06554mEUVwxfYTSLtMJ1XG2NPk4XzTdk=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAHtkkKkc9nyXCuAA--.818S3;
	Tue, 11 Mar 2025 09:25:32 +0800 (CST)
Date: Tue, 11 Mar 2025 09:25:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Mathew McBride <matt@traverse.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: freescale: ten64: add usb hub definition
Message-ID: <Z8+RCo8mGOLIck5a@dragon>
References: <20250129045352.10728-1-matt@traverse.com.au>
 <20250305001901.31594-1-matt@traverse.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305001901.31594-1-matt@traverse.com.au>
X-CM-TRANSID:M88vCgAHtkkKkc9nyXCuAA--.818S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1UWw1xAry8ArWDXF47Jwb_yoWxtrXEka
	4UAFs2kws8Cr1DKr1fZryDAF4fKw1UArn0gryDKFyaya4UXa1DGwn3WryFv34fXFWDGr1D
	Ca4SgFWkta4fGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUppB3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhYNZWfPVKmmBwAAsY

On Wed, Mar 05, 2025 at 11:19:01AM +1100, Mathew McBride wrote:
> A device tree binding for the Microchip USB5744 hub controller
> was added in commit 02be19e914b8 ("dt-bindings: usb: Add support
> for Microchip usb5744 hub controller").
> 
> U-Boot will consume this binding in order to perform the
> necessary actions to enable the USB hub ports over I2C.
> (We previously used our own out-of-tree driver for
> this task)
> 
> The Ten64 board does not have any switchable supplies
> for the voltage rails utilized by the USB5744, so a
> pair of dummy supplies have been added to facilitate
> operation with U-Boot's hub driver.
> 
> Signed-off-by: Mathew McBride <matt@traverse.com.au>

Applied, thanks!


