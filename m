Return-Path: <linux-kernel+bounces-291103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AE4955D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482451F212F6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA26A144D01;
	Sun, 18 Aug 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj51q9Ay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FB433D5;
	Sun, 18 Aug 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723996421; cv=none; b=uC6dZRQ+OdsfwirGc5iVsLNaPwKzsNJPPnIka4lBLfqu/SJp2EhXDQySApr05na0uLzuMKR7Fnp6m8dmtxsDZ21oJGZ34Sxfd7wplgYSbPveGY50KnxvjiaNEfvdoHV41Gqcd2/l78CRAPuQ3v8LUEhk+dbHNKpay06I+RecMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723996421; c=relaxed/simple;
	bh=Tbt+j8CdukwgaYMQtYP6W1t8oyGm7GmGMhbCKDGo68Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/z4tpEexIL6p6iIdZo5ez+XwXga6yCsxdnxoZEmEifHGwbxBflV3fyRT4hnV1L0uH6uywzgHXet6PqmlAlm2XoL6H5C3sFWv6zkApu1Y72vQzlRx69gw77ODzbwjSrNK7sWUyH1/tQ6//nF+daT22krH3iOxJKGPsPwknwh7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj51q9Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C3C32786;
	Sun, 18 Aug 2024 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723996420;
	bh=Tbt+j8CdukwgaYMQtYP6W1t8oyGm7GmGMhbCKDGo68Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj51q9AyJIgvOeP9kYc4J3DyS36ZWdwHjedvBn3XsMz1oH1kpSMXoJpMeUQhC6jKE
	 vFv3NHgqRquBnAXA/bPtLE/VgmFVZd4mud9RVLxGfqJfrpNpS/jbDi6YC6ZqbroY4U
	 Y3riU+BxmnPYT+RRJvegpFIDS54jWYB4SP0ppvgyh3SBRCPPira+7Uqa+72XLSvfhs
	 jiZjZuPKB3aCowSrHV/bU5Gd/l/linsCOsm2lfxkwpug4T0/KMZWJFki5EZcZb6EVT
	 MiAZkVjyMnuejsFi04tCpkLoBtEjpIut3mLHx3UlevKBYMRt0bGVhxGDSsfbAAfxT0
	 LYexSrQ0761iw==
Date: Sun, 18 Aug 2024 09:53:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-usb@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: usb: add layerscape super speed usb
 support
Message-ID: <172399641766.147408.13216803408020032216.robh@kernel.org>
References: <20240815152159.4177782-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815152159.4177782-1-Frank.Li@nxp.com>


On Thu, 15 Aug 2024 11:21:58 -0400, Frank Li wrote:
> Add missed binding doc for layerscape dwc3 usb controller.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dtb: /soc/usb@3100000:
> 	failed to match any schema with compatible: ['fsl,ls1028a-dwc3', 'snps,dwc3']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/usb/fsl,ls1028a.yaml  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,ls1028a.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


