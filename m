Return-Path: <linux-kernel+bounces-573988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E35AA6DF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEF83ABE35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319672620C3;
	Mon, 24 Mar 2025 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihDM1Lzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2226158E;
	Mon, 24 Mar 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832618; cv=none; b=secT5tmOoZjyfXb4Ec0s/pSJjTZvGi2BDxSTyqW2ZKnLmH45kMNHjDs5LDz9Gs+ySoAZI8ReBTFKTk9dVR1j63/GNiE58/Vm3essC8hk9MJjzKJ5o2SBolgYw9LO5BU4rDlX3K+vj6kvnIZEMkmZ9yP8ncDHho32fZNC6Nhqv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832618; c=relaxed/simple;
	bh=VRNuMZ46YoefRymfk92bpusxS2YiPpYOHdDtSJvUv28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC8FXZForh1CfzPUGtoAyvKo6eZmvZnyY7FtpeNWFQyaG7a3P5n0ImVkL7i3Qw6wSLuSgPTlq3keaqx+TNHP/OtDjdkgROfauGsHUK8NDHwC9Z8fJjEKX01yNn+7o6vla9Y8uboBxQp7KAen9OpQHx41HIfRjnDjpAGccWPrNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihDM1Lzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42D5C4CEDD;
	Mon, 24 Mar 2025 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832615;
	bh=VRNuMZ46YoefRymfk92bpusxS2YiPpYOHdDtSJvUv28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihDM1LzcyF7ntp/L6yv553qVXhlfA2d21lvEo2ba33p7z5XZxNhVG6BXieL8rA0rf
	 hHLHAn1CFEkTehALove7hl1eijCG/cuefvE6IIEkdGJhIyS+RTSk0GYtnrsl6Kct3U
	 mCNRwfIym40mhLadEy6sXjEUdJAEPY3+bKQSpIx0VHlikBVxrVnguI5PNp5cL54NWi
	 QzIu9/OYTN3o74c3AxAxILmJ1QhagtOTQKTMVgljsQ6SM4TLwwaztInWEbgS5hL2A1
	 A2jEUCr3mRkcx6mhlPcKEUuF0FIc8iu1iM4UdFPPPlY6WRM+jJeJfYDg253Jp8JA43
	 Op41GcNd0aiMQ==
Date: Mon, 24 Mar 2025 11:10:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: arm: stm32: Document Ultratronik's
 Fly board DT binding
Message-ID: <174283261429.162935.4991717491782236222.robh@kernel.org>
References: <20250321111821.361419-1-goran.radni@gmail.com>
 <20250321111821.361419-4-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321111821.361419-4-goran.radni@gmail.com>


On Fri, 21 Mar 2025 12:18:18 +0100, Goran Rađenović wrote:
> From: Goran Rađenović <gradenovic@ultratronik.de>
> 
> This commit documents ultra-fly-sbc devicetree binding based on
> STM32MP157 SoC.
> 
> Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


