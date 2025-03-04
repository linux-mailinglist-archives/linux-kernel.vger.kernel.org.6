Return-Path: <linux-kernel+bounces-544668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC83A4E3E1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22FE19C4809
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E618527EC83;
	Tue,  4 Mar 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Q2BzRv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FB27E1BE;
	Tue,  4 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101802; cv=none; b=B13siydlXgAwzbLVW1MRemamPiv+TdpNdJl8WTOfGw67inZnbCbPCq4NJdjQKCcWEX2ThcobsSMjLyvyPBk/+0Tb+O80NL7f5lVLVsktslzoF9+JAE6OjIGpHsojf2gMkZmqtbtV6OLeYM9zUYsluXFB0YGo4Ck0oskCh2ZyJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101802; c=relaxed/simple;
	bh=wOZdyUaRyNj68ihWIOygiOcGTvvKLhUnXJHLbU9loN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muOkJ5OfN3mfuNUVD1jdMsM1Zm8Hn1TknxWqNJh48zutSGVqsK8fW6vDN9Iw4BXYa4+G6D53L2CtC4kEJxNLSxt3QEJW6l7kCOf7npFmuTqK0aN5fZIA5LGGgLS4ylA7pmJ6V7v2GP+xgLj82SoanXaUcmdsJqs2P/9O1H2QEyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Q2BzRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5D0C4CEE5;
	Tue,  4 Mar 2025 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741101801;
	bh=wOZdyUaRyNj68ihWIOygiOcGTvvKLhUnXJHLbU9loN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4Q2BzRvoV3D63ntQX7PJjECA5gNDcY3O5MJdc82JtYjlkGjJPffZEmxWvJXkINQr
	 DICUn/02zKB0e2v7InznL8QpLBcNsAEvZapenQfRa1qCnOHw63v0lmbHAruGfblgwt
	 DMFZWZDmWAOsdC+beiNN2Nwvz05DyuZGhzXTSGybPMwKYeVmlD+XlAx06Fia64QOQB
	 CH5/+2lSpMOQim1fFY9YhZeSAHU9oQKu7N7zZpwHLHtm0s8+G/2BX3swytK6SyrH6K
	 pgBsG1zG1xiz2Rv91U41AeVXb00uaSZPNY8rv6FACOh6hJXrQBL23oJLMWo8DF3voe
	 pjQNcqG92VQiw==
Date: Tue, 4 Mar 2025 09:23:20 -0600
From: Rob Herring <robh@kernel.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
Message-ID: <20250304152320.GA2630063-robh@kernel.org>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304101530.969920-4-victor.liu@nxp.com>

On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
> A DPI color encoder, as a simple display bridge, converts input DPI color
> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> bits in every color component though). Document the DPI color encoder.

Why do we need a node for this? Isn't this just wired how it is wired 
and there's nothing for s/w to see or do? I suppose if you are trying to 
resolve the mode with 24-bit on one end and 18-bit on the other end, you 
need to allow that and not require an exact match. You still might need 
to figure out which pins the 18-bit data comes out on, but you have that 
problem with an 18-bit panel too. IOW, how is this any different if you 
have an 18-bit panel versus 24-bit panel?

Rob

