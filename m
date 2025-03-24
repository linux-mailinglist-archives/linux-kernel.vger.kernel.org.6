Return-Path: <linux-kernel+bounces-573453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69FEA6D77F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475BC16E19B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1FB25D915;
	Mon, 24 Mar 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8EPnFty"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3B1519BA;
	Mon, 24 Mar 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808809; cv=none; b=K5+VL2S9l4gVi6joPEeNcQB0lBU/zGbpJeBOeBVJrRCyJfFcGZaFugwBHw2c6vIMpGCpGmmiKx8zoFGX84eAiumBPIVhteslkHTz00IMhFF7cK9wmamYrY1kHCp+UxDrOcSmK4LlO2IHhmHigL+gw9mzvlG6u/tRF2BV4Oqicrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808809; c=relaxed/simple;
	bh=H4hSWm3+0vSdTwfpHEZaWWMhrb8/UitvhMtuYnogIRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lj6rSxI6A2NCWdjQrWiJE7Tc3+Z0AHZ2f6oKdEKlEBYrkG/tpfx2YGwTestVOnTdJsKjdOEDi8qbvdW3zc8agtTWsH60VbXKbFk0O5cnmPO+DMlL0IgwB4f1lDv3ufai++7o62I1GESvsuqgJwfJHSCFWErsHYwr4TBB4Ihz83A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8EPnFty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6242C4CEDD;
	Mon, 24 Mar 2025 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742808809;
	bh=H4hSWm3+0vSdTwfpHEZaWWMhrb8/UitvhMtuYnogIRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8EPnFtyK2P9GsInw4s3FVly8Fms0US3jqsf2gRY/Z/Wk8PbkmG7g8Uzfb9QBCCuE
	 KziHU9pbxhjntelVwlitNL2K5XK62VT2toTES+Z5h8XOL+XJH9vUDH93EVMR50FLri
	 xgTAb8YZRzE7F3pAxcEuQxbU/bUOHWmDaNIQvZI+epgIJ6xVXfLgIyHsPIhuxz8yrN
	 lacqD+perTWUK2daQxQy7NGIITCSDXIBSKAuUrWRDs8UQt4J0ruTG6X1iY8nNt5ITO
	 iMBlzV/56m1RS8DVx9BqhREVyqqGMmRsmrNrig6wUika/30+9iBJI29iMIU+fzO3OI
	 /3dMGXkZW/vsA==
Date: Mon, 24 Mar 2025 10:33:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "paul-pl.chen" <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 01/15] dt-bindings: arm: mediatek: mmsys: add
 compatible for MT8196
Message-ID: <20250324-bipedal-berserk-carp-6eeb5f@krzk-bin>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
 <20250321093435.94835-2-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250321093435.94835-2-paul-pl.chen@mediatek.com>

On Fri, Mar 21, 2025 at 05:33:30PM +0800, paul-pl.chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> In previous SoCs, a single HW pipeline was an independent mmsys,
> which included the OVL module, PQ module, and display interface
> module.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


