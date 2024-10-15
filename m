Return-Path: <linux-kernel+bounces-365998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8061099EF5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A73E1F255C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D801B21B2;
	Tue, 15 Oct 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jbkm/EVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C8149E16;
	Tue, 15 Oct 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002108; cv=none; b=rpm6vsyELLfc/SuC1SK7QBzwD5rvuX2VmKyav1j+WPkUtj9weH86KdZ/VIHvoM/ZYA86Kjxh4XlmKT/pQBClrQXR7Agv8Ijms0NZRx8505S/0vHCdDeBYb0afv/BBu1pErrMIT+Z72O2sqiMN0xWpphLxnld6Vl0Snw8XnloIvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002108; c=relaxed/simple;
	bh=y9Remuzhazsl6jG4wSR5jXZQPRLnrYUCmNCQ7YesZps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNoPfWki6bzVpvrnlmHfK+QhAe1m9wN9X2i/sWC0G11slzMRTeMAY6CpJUv9f/h7gc/BtUbANiFFvzTW2UIFwBtcUFCYlPqggNekl1mjeTbylwoxjMo9GFhHcghHQliWOf3ynwxKepmo9L+VlJt8Z+/ZkCtdTHrKSpmGAHGTQ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jbkm/EVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50C9C4CECE;
	Tue, 15 Oct 2024 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002108;
	bh=y9Remuzhazsl6jG4wSR5jXZQPRLnrYUCmNCQ7YesZps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jbkm/EVOBnWAwjn0Odp22gnMBUiYL6syoS5SHuyG+e4D7572qMJgnKfvVJPTL/S6w
	 HDegeDPnibo9WmnsXAZxaeC22x5zSFSLSF5RT68Agu7KXe7eicpzvZ+FRCJbUs7UeO
	 qxx8t2v7bukGdXXLJlWMdS1QxyKbk1qj4ZNsHwl8+AG3tJRN7A54q3xqud/1O4DxeM
	 tGkMAzmK7ElI2fVPl2FOHbSk8FtDJcZOacm7/dkh0FJQkG4jTBvxUDCdr6SimJwO0X
	 aoRwyHVenpuSV9SbM9FsX4huGBk5t5cDnsiuMcvOIbMd+cbH9vUUgzBXWqKoIWG4Uk
	 9o5cJ4AlmjY6g==
Date: Tue, 15 Oct 2024 09:21:45 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Message-ID: <172900201303.807870.3079581090690762853.robh@kernel.org>
References: <20241015-imx-se-if-v8-0-915438e267d3@nxp.com>
 <20241015-imx-se-if-v8-2-915438e267d3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-imx-se-if-v8-2-915438e267d3@nxp.com>


On Tue, 15 Oct 2024 14:31:00 +0530, Pankaj Gupta wrote:
> The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> creates an embedded secure enclave within the SoC boundary to enable
> features like:
> - HSM
> - SHE
> - V2X
> 
> Secure-Enclave(s) communication interface are typically via message
> unit, i.e., based on mailbox linux kernel driver. This driver enables
> communication ensuring well defined message sequence protocol between
> Application Core and enclave's firmware.
> 
> Driver configures multiple misc-device on the MU, for multiple
> user-space applications, to be able to communicate over single MU.
> 
> It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>




