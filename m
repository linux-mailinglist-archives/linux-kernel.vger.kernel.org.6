Return-Path: <linux-kernel+bounces-203455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5C8FDB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A971C21EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115EC8FF;
	Thu,  6 Jun 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6ml0GK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004A646;
	Thu,  6 Jun 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717634014; cv=none; b=BrlV0WdV944MgB0MmEeFhbcppj/rODxRFGPFXCNeQtPvYWBxFSBgXuXvYKFts3MM/BNoTyxe3jXS398xe7Mx5pWYZ+JrJVY4gjxH56sS8sgXAcviU7VsL44sNSLI5eZ2rlj8+/258XVuZqCSLL6fNrOYf0jvAVWjNWf9MvUhosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717634014; c=relaxed/simple;
	bh=56qUZqP/b9o5DLhPAmeKSWqAvPFqXnecS90zH8EEqvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2ZURfC7FnOZsu2vi9dVxncwu2gE4X0J/NJsY8MGWeNMSeNWlH235Nq4CC7MHQpzEX2QTN3eqXRkScq0hH7OUnIaxT1s/VGyxK+3fnHkxOT9RLcQPoNHOfXD4pt/M3yNEuuzn9oh2/tY7XG9u7IYWsTGFUD3zZ2Dm6YR1mL460I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6ml0GK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72639C2BD11;
	Thu,  6 Jun 2024 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717634013;
	bh=56qUZqP/b9o5DLhPAmeKSWqAvPFqXnecS90zH8EEqvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6ml0GK5ln8BzDQqNTUhmFXOlKge2R+ZxDTU1gpyOWxj7gGZbShGTGL1/p6yczmuu
	 MuNpPaHlO4siG4s+uqlzmsa15hrL8J8XDoPZBqKEGjmOGZ+om1+W/VMrarYKE3tTyp
	 kZkCAfqLa9Z+Y4HqiMBDCjMNXfx6o5p3nqcyFoCR2gV7qjdjmIXJcvCYyRKAEn1ZcO
	 tb90g5xhpDatlVKVzZmAk2x4+gJQxWBrR7akawDsNmOtssCeSfvbEUgk2TnSy1lk0E
	 FDib/zdUE0GgZ12jUT8qIi1Wq8trXGjhPdB30msXlkji0SL5n+lq2cQI+gB98zaNLl
	 0/WzEJ9G4wkeA==
Date: Wed, 5 Jun 2024 18:33:31 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-amlogic@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: nvmem: amlogic,meson-gx-efuse: add optional
 power-domains
Message-ID: <171763400890.3519005.9651126174187029952.robh@kernel.org>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-nvmem-v1-1-ef6f10c86a63@linaro.org>


On Wed, 05 Jun 2024 11:35:22 +0200, Neil Armstrong wrote:
> On newer SoCs, the eFuse hardware can require a power-domain to operate,
> add it as optional.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/amlogic,meson-gxbb-efuse.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


