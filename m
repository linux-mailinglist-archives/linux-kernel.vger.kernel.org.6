Return-Path: <linux-kernel+bounces-546242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A96A4F847
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390703A5E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1C81F153A;
	Wed,  5 Mar 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGTIN5MW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6E17555;
	Wed,  5 Mar 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161101; cv=none; b=ZNNL9jZUr5iFy+wA8GlxfYczeNDUuk5kS+JsHGdPTBRux60NxOihh/wAFQUBGfiXlnJoq4IgEyeT2pwuOYbBXDdG4w3o1tBI3P247Oib3EdIt1yrhfh/WG04RQSuAimpFfBCN4SeEYez+VZ3cH12DQmtzyUE7aMPJvPgGkeyIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161101; c=relaxed/simple;
	bh=QyFRWvas24e4KFCBZT6GjOM6RBxXtM6JmFhw+HxMXC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGGY8RXdOoIwZNihDgD1rqCnIFMSLjPofyMw/+YmJMkdRcBmyNKDLQJ2xifLf0kX8DODkm8p3pD0BKPCqYlundI3QPp3ojDgkBEs10dg8m+qyqd61UXpVj5x3K8vbblXvUO3cc1ksalnAMGy2RpbV43wL1UptJu8+9cU4fHKpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGTIN5MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19D2C4CEE2;
	Wed,  5 Mar 2025 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741161099;
	bh=QyFRWvas24e4KFCBZT6GjOM6RBxXtM6JmFhw+HxMXC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGTIN5MW2xH/jYQsYk7OaCKGbVAnVS1qUqybaNHjTY3DW+0wnGQ/qFcXFsK7ojCzV
	 eFDDIp3WSCk48TAx/mNGH4e1R8rE6cC7wfNvNka/3/ezu8q3jbhWxBoHZDmxQ1H/IQ
	 xSeqI1glSzLexuE1/sAG+xdxSby4Yye97ToTijmVpkFe78+i9xK1tvnggp+zgSLiqx
	 Prsp/d3TV/nwoeY655ghQHPAcmEEPRJgXzwCoxC9KWBJp0R0Gd0MTwUcLYaSTEit7K
	 V9Jmmhwx/tktmAmp2fb3muPRDDW9c9pSldd20LpuRRGmXsv0UlrEWSWEJ3fDK3i4/j
	 iOCvRKsELfoeQ==
Date: Wed, 5 Mar 2025 08:51:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 1/5] dt-bindings: display: Document DPI color codings
Message-ID: <20250305-important-quizzical-chamois-ff48af@krzk-bin>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-2-victor.liu@nxp.com>
 <20250304-deer-of-striking-pride-ff6e86@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304-deer-of-striking-pride-ff6e86@houat>

On Tue, Mar 04, 2025 at 11:33:44AM +0100, Maxime Ripard wrote:
> > +properties:
> > +  dpi-color-coding:
> > +    enum:
> > +      - 16bit-configuration1
> > +      - 16bit-configuration2
> > +      - 16bit-configuration3
> > +      - 18bit-configuration1
> > +      - 18bit-configuration2
> > +      - 24bit
> 
> Do we really needs strings there? It would be much better to use an int
> plus a header

So DTS would sill have a name, just being a define? Then what is the
benefit comparing to strings above in DTS readability?

Best regards,
Krzysztof


