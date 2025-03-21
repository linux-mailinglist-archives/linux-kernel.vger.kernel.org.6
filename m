Return-Path: <linux-kernel+bounces-571988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6294A6C50E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07433AFA0C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F701231CB0;
	Fri, 21 Mar 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elOSWnqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641D230BC5;
	Fri, 21 Mar 2025 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592239; cv=none; b=jJz3sxpI67kQv99Z/jEuPBE7VOTVQ7OiHO2JpdfPOu511c5Zd53aEMcveqkNfi+edVjd//GKygRAISyJ8aEJqrkekkDgXjcKI7r8vBZM1HnzktMKCyOY6jcJTLJsmKAmHcW0nGYEV/rNrt9VtBTk+emEBphSbGHXYI1J42aj580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592239; c=relaxed/simple;
	bh=gOfJYQK0p2G/hVDRAJhS7e5zivlY9TzR7mIpXiz5tCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u65EG73djf8rN8N5yjcH9vjKHsLn5Zt9n7AmY+79WG+Ig03IklYtS8+22LNaaPlQp50gwuH5eXW4KxjXrvetmZUcu94A1jvc50yyb4NX2bbMORibPATBISix+UGbN3vG9XGHwZqY3ALcHX72FIarnfSbOAwzVKm1+UGITSWVCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elOSWnqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3801C4CEE3;
	Fri, 21 Mar 2025 21:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742592239;
	bh=gOfJYQK0p2G/hVDRAJhS7e5zivlY9TzR7mIpXiz5tCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elOSWnqq93wMVkWczPA13/4IKBIS/gEcP7YQ2gSZmRHYA5dxERHpWiQMGqEttx5+6
	 dtGSu+NqKTmIi3smtQkSW6bUyAvjowQebMEIXA9ThllTMPsHanMGVeKGnVtoj/7eBY
	 A9JP7y5pzvc85LwAPV4NSENTQTUxxdRxahnTgBBHm0Pv1Ap01Ou7h2Hz0i9o0EpAin
	 OP1n7xKOjVPGCkKDA3u45tIfccztmN4asvqhawYOBJZILZPNql2O1dbsgAtZJKl3uk
	 R8PyeSGEvDYSdUWhqAwFeriShB2dIxPU5kTpLVDWhdAsgTp5epfvRcBB96H+bG1BHL
	 CCTw267G7rEiA==
Date: Fri, 21 Mar 2025 16:23:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Tiffany Lin <tiffany.lin@mediatek.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: mediatek,vcodec-encoder: Drop
 assigned-clock properties
Message-ID: <174259221258.4077511.5846925634356953161.robh@kernel.org>
References: <20250317214621.794674-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317214621.794674-1-robh@kernel.org>


On Mon, 17 Mar 2025 16:46:20 -0500, Rob Herring (Arm) wrote:
> The assigned-clock properties are always allowed on nodes with
> 'clocks' and generally not required. Additionally the mt8183 doesn't
> define them, so they must not be required in that case.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml  | 6 ------
>  1 file changed, 6 deletions(-)
> 

Applied, thanks!


