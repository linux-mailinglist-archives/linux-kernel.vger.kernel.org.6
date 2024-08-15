Return-Path: <linux-kernel+bounces-288182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8539536FC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F7E28CD0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A571AD402;
	Thu, 15 Aug 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgBzueyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131001ABEC7;
	Thu, 15 Aug 2024 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735252; cv=none; b=o+/0cULWmB4U7WQ2oL7zzxn+zdUW7/fN6inTumQZhs4iaJLbBdfnYWqCIGWXNbm5K1BCXukL2mzelTvI/xMpIdmQAts4zK3wI9dEQK0E4w6fnTbahOcV9QJaXlRO+U7SRAdDsgYmA9jGWKdygiuW6dln5CFhQJwjydQHb/5ZzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735252; c=relaxed/simple;
	bh=+M4cVZkYRpLXJ02TXAHcDwUpNpTBG4Dvk+C/y1KGbkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4zzxbsctlLQK3PNH/f4guMiwnDZqTupzH8UmVx9O0CPzD0oQg9bkIvlE2zdZZ+kBI+RuBM9lYP2rzWVUyz9yXEbzBIfLF86hkaMQtenmTNNQSVDwQhnkIfu2EPD5PDAf5lVHgoFTN22dwcJieKD9eN+U9tA0Kz8WeWZTnHk5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgBzueyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D5AC32786;
	Thu, 15 Aug 2024 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735251;
	bh=+M4cVZkYRpLXJ02TXAHcDwUpNpTBG4Dvk+C/y1KGbkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgBzueyDdJbTzPWj88aFQKIgMQKX2gHRynHdEeYLK9JmT474SMMpfwo88gJJePPFA
	 lyq4y1dl9x0QE0+Rk1JhnWcrkxvWyUE/G3Kx3kdYYrgFrla5rHz1NHEz9E+iwDFV9j
	 2QLWZ6isMznrWJxHLVL3wgDSMQEDrLGjYE3DsTBvcRoCbAPY4Y0kPO+mUSUoiBbIm9
	 6CyvDTfeq8MzQ3bkNlC79I7mt+JVT7VmPsIOETXJOuwz+WpcdJnSRjeNpeQ8PNP4LF
	 Pi5SCUn0g2G0iqvdXb+9NQLPYzsWDAVhKMX7TMjMihdexGiud3iCE7Ls2Z9+l93Ztd
	 2nQYVOhrbJatQ==
Date: Thu, 15 Aug 2024 09:20:50 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, ilkka@os.amperecomputing.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	will@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] dt-bindings: perf: arm-cmn: Add CMN S3
Message-ID: <172373524966.1843320.5253926062860157964.robh@kernel.org>
References: <cover.1723229941.git.robin.murphy@arm.com>
 <ec64f4d13b3b30c2ff242deddd302b1d1e256bd1.1723229941.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec64f4d13b3b30c2ff242deddd302b1d1e256bd1.1723229941.git.robin.murphy@arm.com>


On Fri, 09 Aug 2024 20:15:46 +0100, Robin Murphy wrote:
> The CMN S3 PMU is functionally still very similar to CMN-700, however
> while the register contents are compatible, many of them are moved to
> different offsets. While this is technically discoverable by a careful
> driver that understands the part number in the peripheral ID registers
> (which do at least remain in the same place), a new unique compatible
> seems warranted to avoid any surprises.
> 
> CC: <devicetree@vger.kernel.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/devicetree/bindings/perf/arm,cmn.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


