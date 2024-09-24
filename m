Return-Path: <linux-kernel+bounces-336849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E09841B6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9179D286756
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73D1553A3;
	Tue, 24 Sep 2024 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfSxoE7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA41552F5;
	Tue, 24 Sep 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169087; cv=none; b=KZBeHYZe5XJPLi+oFSp45M804dIbwNKylD5wUeaPODScyIYZLed4NZxKvEuvXyLp+Qcou1j/R5OepedFM4+ovtlGUz44GRHN/JRsDpdiEL6UN+s7a1Kr89uEZoVsv3gZAF7qyGOGmPLsU6YORMGhvVKIR+i29yINAAa2isNsVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169087; c=relaxed/simple;
	bh=Tbel8uvGtCqj4KcUrojivaO8C+VEW00V6+EQbi3lJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QopK0wONGeLaEQLQ5k9Evr3nwJBnmOLTWV6i+sVyKzaRF5aTAPjuo0GzqgUbXu2F+mPToo7FQ45UoRzqHLyVS0Fg3rQ3OufqIqW1Cwdyzmbbg7wa+7+3I4Z5sy5l/mv8cOCliTrylmgC16CoPz64plyX9Ok6wl2r5AkNTcGihLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfSxoE7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486F0C4CEC4;
	Tue, 24 Sep 2024 09:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169087;
	bh=Tbel8uvGtCqj4KcUrojivaO8C+VEW00V6+EQbi3lJAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfSxoE7MAm8p/dLPymACTis4MfzHpHjwe3QUIUF2CX0sF9Nk3l4HqHp8H85CZfRrl
	 RnCxOEOc/kiZ1R+cp4gtpHU+kbVUTqs2FXE4YR2eIAv9A9IroRjmwFg2wqEcEmmsN6
	 Qs9XA4USysKvDEbTmsOmr6Uu+JelxT+Qd9KQrZMk7mgzUfPGhLlpTrDVI+uRCMPGKe
	 3JnT7CUNuLAVLKUv7UAvKYC7cNsQVzqcL+Yt9JlbrIdhO7YNQFAjMC3cX80pIzahCX
	 P/nXdIRe2VeQVV3sZvh01/E8srVmopGgjmprLTS4aoHFmoiPDMU/SBezeQ3WM2OEZJ
	 9TgjCwL+NREXA==
Date: Tue, 24 Sep 2024 11:11:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, krzk+dt@kernel.org, ck.hu@mediatek.com, 
	robh@kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: mediatek: dpi: Add power
 domain for MT8183
Message-ID: <4djlcabqjkq7thbxadjbbi6oumybnyzv7biwawke46ctjccwye@rmqougrj6pl2>
References: <20240919112152.2829765-1-rohiagar@chromium.org>
 <20240919112152.2829765-2-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919112152.2829765-2-rohiagar@chromium.org>

On Thu, Sep 19, 2024 at 11:21:51AM +0000, Rohit Agarwal wrote:
> Add power domain binding to the mediatek DPI controller

That's DPI controller, how can you add here power domain binding?

> for MT8183 that already had the property in DT.

Best regards,
Krzysztof


