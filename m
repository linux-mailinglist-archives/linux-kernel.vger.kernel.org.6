Return-Path: <linux-kernel+bounces-575592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140CAA7048D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3651667EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D125BACA;
	Tue, 25 Mar 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKdFWddW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDE25A2C1;
	Tue, 25 Mar 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915139; cv=none; b=Uiu5ub+wOrMhznmaxBCx5yLGQTpF2KXuv67n36r0gVJ6OUAfz3zJgvck9Kn5yx55p1Kgz6ETwuwD3OlqCvF22VhwuVCfE7TYI25l5mGiyv39rEVBOUjWYYXpQmulbx7kShcJcIz5nC2DIYh1P0VN54z2QElR3fB0ssgLZTjqkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915139; c=relaxed/simple;
	bh=pxDDzt3nXUXBJ/7Nv/uhVEfW6KoJT8d7Gu3T3cGsCac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Gdq+niyP5MNLf9vLDTSdSMDmVxDUZ0Hhm2m5LWpBvba8W3aRk7Vdt74tiY/cj2hRXsTnwMVbjPzk+UGN9VmX/Ro68Me4F0iCuygHSIqllMZcMnfUyeXfdcvSiSCHFrTMKDLwGwfHZw7K5se5R6UB+iFkw8POUZZ8qtCRJvUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKdFWddW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41210C4CEE4;
	Tue, 25 Mar 2025 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915139;
	bh=pxDDzt3nXUXBJ/7Nv/uhVEfW6KoJT8d7Gu3T3cGsCac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKdFWddW8jtX6bS9n8hjOA976IYOYP7nA6athtLfM+7hFY0ixM+smcB30Vj+9uSF7
	 ktsCSkppAznydPwy03iNQ1gukIoxNeM41eVmsgJ0a1M1cbbSLCfNpyInFrSqUl/Aw5
	 jMObZVGVY+cSvnVNsEYx1xIGvGY9gyG5Uey708/ZV16iPutpSKHhN3to+upNO6Uayq
	 P7J91fFRG5NZImijGtk6IlwSccukWf9jUYE92yLjebGO0eGmmuGVtwyPTUNpx2qSig
	 fK5o4aukrUrMzRpwOqmSb/Qjc5r2MDTrSClmITbLV/IdmO9iXR5XzQ+AV/w0BGfTKD
	 23m9njrR00J6A==
Date: Tue, 25 Mar 2025 10:05:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: stm32: Document Ultratronik's
 Fly board DT binding
Message-ID: <174291508527.2051452.5158369080088647376.robh@kernel.org>
References: <20250325110409.2323611-1-goran.radni@gmail.com>
 <20250325110409.2323611-3-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325110409.2323611-3-goran.radni@gmail.com>


On Tue, 25 Mar 2025 12:04:06 +0100, Goran Rađenović wrote:
> From: Goran Rađenović <gradenovic@ultratronik.de>
> 
> This commit documents ultra-fly-sbc devicetree binding based on
> STM32MP157 SoC.
> 
> Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




