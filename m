Return-Path: <linux-kernel+bounces-527079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12818A40713
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67127420DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172A207DE6;
	Sat, 22 Feb 2025 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQH7rc+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CF2066DA;
	Sat, 22 Feb 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217531; cv=none; b=k2UwooKvVIW14+baVnQozh55XXeweq+udu5pKw+VrKQ20GMhutVSlmkjF8x6+B1PVWwP7HqpukgL3WmjpxCxeXxzCZwo6f9sZRJOnGN7FjD2eaHC9XvwQbnRdDBbvrSd2N5zmcMpzpEC4rh4Fnkg1mojigVIsmNzyPm0IIBbkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217531; c=relaxed/simple;
	bh=+yD530lOGCPFmwWjgz2XLbqeuEp0ZxyaxcDKhfIMZNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTCmKRDNV2te6fz3ICk0eiPX14+xu8tcFQdUkMWJ3r5qMRNyC/syhbnBXAm+DNkHHOWAnc5z8quBjzvf4S/evVSBASGjz92P68YPH9FzaTr4PnDwsOgyB81KxEu8avl1gzfA98J117bU+dlPvhpyVkMvbBvZR5t05WXJmhULe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQH7rc+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D91C4CEE6;
	Sat, 22 Feb 2025 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740217531;
	bh=+yD530lOGCPFmwWjgz2XLbqeuEp0ZxyaxcDKhfIMZNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SQH7rc+Q2YHr28OXGOnaugKDvk7349T3YGrvcH1Z+KVcbFT/IQlhGvGd5pn4io3sT
	 gFjCciWD9klu2NvJBVU346KNaZpHKsP/oOfY1PozAKQB302scObTcKi2P/oPX1yy/C
	 7e7q1twgNeUnx0mQqZkYpLzWF2amBgMZRhxIjDWU27749dtNTHus9hHY5xaMgokybm
	 YEjsQ87hA6IOAg2gTJpkGAVkdRLAikxYHg7lFmsRzfZrtgZSmMFIgcuZCeL1jrykMJ
	 rejtbai3OSWildxZpQpe+GOXes4kO91A9emkdGk5cG08A/c7X33lJ9oZT2h5izV0E4
	 YiCNGbzUtGAyQ==
Date: Sat, 22 Feb 2025 10:45:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Friday Yang <friday.yang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 0/2] Add SMI reset and clamp for MediaTek MT8188 SoC
Message-ID: <20250222-miniature-coral-starling-eda1bc@krzk-bin>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221074846.14105-1-friday.yang@mediatek.com>

On Fri, Feb 21, 2025 at 03:48:30PM +0800, Friday Yang wrote:
> Based on tag: next-20250220, linux-next/master
> 
> On the MediaTek MT8188 SoC platform, we encountered power-off failures
> and SMI bus hang issues during camera stress tests. The issue arises
> because bus glitches are sometimes produced when MTCMOS powers on or
> off. While this is fairly normal, the software must handle these
> glitches to avoid mistaking them for transaction signals. What's
> more, this issue emerged only after the initial upstreaming of SMI
> driver.
> 
> The software solutions can be summarized as follows:
> 
> 1. Use CLAMP to disable the SMI sub-common port after turning off the
>    LARB CG and before turning off the LARB MTCMOS.
> 2. Use CLAMP to disable/enable the SMI sub-common port.
> 3. Implement an AXI reset for SMI LARBs.
> 
> Changes v4:
> - Use 'devm_reset_control_get_optional_exclusive' instead of
>   'devm_reset_control_get'.
> 
> v3:
> https://lore.kernel.org/lkml/20250121064934.13482-2-

That's not a valid link. Fix your email client.

Best regards,
Krzysztof


