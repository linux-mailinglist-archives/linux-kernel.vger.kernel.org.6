Return-Path: <linux-kernel+bounces-321748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE77971EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F1B1F248C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB3D13A3E8;
	Mon,  9 Sep 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZsAWBkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6B139CF2;
	Mon,  9 Sep 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898440; cv=none; b=r/N4mDhYZgpJJ1aWwkmEQ4JFK1uLVdm2Zy0uuckat/loejWuO2tKmYtaqWwnyjYZXaqWvls9YgLesPfJT6arkNJVvy6IS8ozbYTuTM1uGh6tLYDtZzzkNnO579dgd4jYSt/ne+/Mc3hbux0ilrM8CQMzQlfWRDX34bFl0iouFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898440; c=relaxed/simple;
	bh=yDChzJjmgW4nM5O9QsBLIaNDGh7qLwtF9Pzw8gaiZE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2Hk4jSC5N9rFxGA7/UWTfo4pYo+SeiZle6l56SBjOvipCVT+xDBv9XKhSNPmBDXU+zJwjSF6oes60zcYImWnKqnfTxnu7akhijN5UX5gA5YBDk2wcVq7XmABwp+t8OdR7G3etZNgrFFWr002/cs+EqGEB6GPkZeCU5IjPwfzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZsAWBkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68860C4CEC5;
	Mon,  9 Sep 2024 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725898439;
	bh=yDChzJjmgW4nM5O9QsBLIaNDGh7qLwtF9Pzw8gaiZE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZsAWBkc1G1NQkcsSfhiqCXxlydEAaGbpwbSz25Wmo0unaFvyI7K4Z7iWGTAfnB6H
	 kh2clR5a9PKWr+rd36vKBo1lYJ/5CkSkeVrsvRGoRyGvaEml+xRBJJfeYF+F2feu4T
	 lDM7rxmkOcFqnQfNaKXPe0VorUsuEHuZKlEbyfroVRZdvL7L/+8pTizUt9y9KEPJrO
	 PXKMMysEOCxQL5Pkinfzgv7SnLvINHPQb4DoOejXE7Lozcq0AD9k+54Vrz4pqpHNdi
	 JKqOq7ZKZLTV4ALSGkayNabL/u4oef24HYgfo2QqfVn3VCUI4M5mtq3qmF+TIElc/N
	 hXRx50e987HdA==
Date: Mon, 9 Sep 2024 11:13:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 12/13] dt-bindings: mailbox: mtk,adsp-mbox: Add
 compatible for MT8188
Message-ID: <172589843790.327330.8035137632260512976.robh@kernel.org>
References: <20240909111535.528624-1-fshao@chromium.org>
 <20240909111535.528624-13-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909111535.528624-13-fshao@chromium.org>


On Mon, 09 Sep 2024 19:14:25 +0800, Fei Shao wrote:
> Add compatible string for ADSP mailbox on MT8188 SoC, which is
> compatible with the one used on MT8186.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  .../devicetree/bindings/mailbox/mtk,adsp-mbox.yaml   | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


