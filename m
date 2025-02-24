Return-Path: <linux-kernel+bounces-530102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB8DA42EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862061695D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4161DDC2E;
	Mon, 24 Feb 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaeYlsBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF01D6DB9;
	Mon, 24 Feb 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740432267; cv=none; b=gJ0eDD25Q1MgP0PPKiFeOKBJ9X0cawEG9r/jrN9vjhYV4Jy8zEk3tvHpyBRryC3pAybh4qmC22qNLch53xAjTo4WGyoo57FOTD84reO7aTSGOxI1UmfqnVZR3XG7VYnpu3uX/50ufQ95w3pyzF/Mvr4POVwL2JHmJY6tFtsXLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740432267; c=relaxed/simple;
	bh=OH9HRn20JiKKaAGSLEL4MYnRi8OT3aRzUFDVE/OJuug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmMyXLyHksOEu4B29Nek1CbamyF4G+h0CTt/Jck89SklTOkX5opvqRI7dM68omiN2ZB8KGyOpfG4B12bKIRSG9chp/Jq/j03WgH+oW3iiq+GOID2IKJO7vuP+BQtgPYRGxMPcd7xwHrbR9sLPBN24bs9mT6MYO6816nIuixLRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaeYlsBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C99DC4CED6;
	Mon, 24 Feb 2025 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740432266;
	bh=OH9HRn20JiKKaAGSLEL4MYnRi8OT3aRzUFDVE/OJuug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaeYlsBdL/4Fb5unmU8HsyjnGf8zkxlmb4nv2ssrjKIp4Y3tGfs25mWqiFyRaPhg5
	 yyPJ0/RMETv+HhXDUiEQpEarCuhfMYLCjI8rixNWZrYL5zh5bWiuSEhyb+lQXKZ4Dg
	 3QETmDTebYntHZOC/ARZowJRnBo7ezfOeE9h13nVoZDzfYXxYxCtdYg3zcDBomyfJX
	 19luIYfne+3yz3/XAvcO0/9X3xaQwMloB5G9m3RdJWAcb7EebcXnUW5hDpNNoqQymZ
	 /DrqLIpwKayCvt0f4FoW1eRX5bum6eESBqggFN/RofXgWqxPPJX027IgDmXWunSxja
	 Az2qKUGIqzCoQ==
Date: Mon, 24 Feb 2025 15:24:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v4 1/4] ASoC: dt-bindings: xlnx,i2s: Convert to
 json-schema
Message-ID: <174043226450.4106940.4348756285400472131.robh@kernel.org>
References: <20250224182548.2715896-1-vincenzo.frascino@arm.com>
 <20250224182548.2715896-2-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224182548.2715896-2-vincenzo.frascino@arm.com>


On Mon, 24 Feb 2025 18:25:45 +0000, Vincenzo Frascino wrote:
> Convert the Xilinx I2S device tree binding documentation to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 --------
>  .../devicetree/bindings/sound/xlnx,i2s.yaml   | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


