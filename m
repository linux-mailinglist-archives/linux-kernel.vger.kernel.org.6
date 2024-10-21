Return-Path: <linux-kernel+bounces-375068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF809A907C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E4E1F21FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5AD1CB30B;
	Mon, 21 Oct 2024 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMYqn+Ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211FFEEB3;
	Mon, 21 Oct 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540818; cv=none; b=PwOrkX2cEG3MGxcjG7vA4+xsCxz/T522HkEY0+YBiRJb0XonWmddpNtzoOs3W6PWdmkXPf/lL3+bTp/3FPoQPfjc0h93j/RhLSdGS7J/LSdm5XLc/CeJs9p2B3n1tRVpswmSlgrV5/Ps4SdnW6mBjquOQ00Q2zPxmI+W5hIizN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540818; c=relaxed/simple;
	bh=eZaq3dA06VETSIpGSXwN5HMHU95wgmj1XtfLBrZx5aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7I7x0Oa7/jP4925pWJcZj9fxWAoDnV/rbGIXYroC9+m+HGek37LbQlzX3p+eNvM5aOey0ZvTCkEhkkJkGW6ae3sZdU0yh2uowL8gwlSSZ+NFAdajV6e34EJr+20KJJHM4kEd4AJjg6TPQgvCAV3bh55YtMSrcVjrHFBqeCQuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMYqn+Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A7C4CEC3;
	Mon, 21 Oct 2024 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729540817;
	bh=eZaq3dA06VETSIpGSXwN5HMHU95wgmj1XtfLBrZx5aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMYqn+Ss9MXIUlWoTTLL3RnMcCBZZGpR1a8ObkH/fA/Qy/9aMDJTUYMuTpONz1cBK
	 RgK6/2/Z8daitjxwis32xLYpzN8J+xtEHTfv0CIzbcHFaF1W17i/HdpXEIs4M7mnZJ
	 irKettxw57nzO8QfnczB6+uniIwHd97Cn6B9QzMiwFNrkx70zAcyShiPmAmN10rdn5
	 11HdjK4ZhXXnTOg/TYKXLIOtLnToZyYsisOOsbiVbSWU3HsHQ82U8Eh1xyVL/4+k4G
	 2/Or2ni+H0ivWAq5x8cdI5B62YcURg64Ynr8rC4FlRfc1kIme4Hl7K9i7f83t5dJt+
	 oAtiWluE67tQA==
Date: Mon, 21 Oct 2024 15:00:16 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v9 2/4] dt-bindings: display: Add powertip,hx8238a as DT
 Schema description
Message-ID: <20241021200016.GA1040708-robh@kernel.org>
References: <20241021100224.116129-1-lukma@denx.de>
 <20241021100224.116129-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021100224.116129-2-lukma@denx.de>

On Mon, Oct 21, 2024 at 12:02:22PM +0200, Lukasz Majewski wrote:
> This patch provides the DT Schema description of powertip,hx8238a
> 320 x 240 LCD display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
> 
> Changes for v9:
> - New patch
> ---
>  .../display/panel/powertip,hx8238a.yaml       | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/powertip,hx8238a.yaml

These bindings are the same except for compatible. Just combine into 1.

Rob

