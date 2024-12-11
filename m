Return-Path: <linux-kernel+bounces-441302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1E9ECC84
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127E716189D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728923FD18;
	Wed, 11 Dec 2024 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUMLJI6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446923FD03;
	Wed, 11 Dec 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921312; cv=none; b=PjZIr3Gp65or3Vhe/XJaxmYRqZsG9FtFuT2/J+H8jV40eFZ5bxnglBfP9LZlI2sUULJY3goG0uWCOVehjMxFZD5BUVcRAiBhxHYtKJVQ/e96IdIqdCm5LduYTLl6TKmaXkSC67jjMUl3yUxR898WDk5Cc0zfF6YF7aCHT75HyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921312; c=relaxed/simple;
	bh=Shdn7f+RvvA769JK9QkK9a1n///yVT69DDvUm40aFzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EUz9nWoolOADlyTHJb3VjMJEOabpDIm5RSaFB1iBohDmb7AoRS4SokHHD7IVQlCt9nETKqwRhNjZY2aTGlFXZYCfsFBwhbalWaSc6ELy/m+D8oMiWNgxJn/J9dOcVRhEOh3iNbb7YcbtidgS4IxoK7oiGjMbQ8Vv/hNe5odfPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUMLJI6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB763C4CED2;
	Wed, 11 Dec 2024 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733921312;
	bh=Shdn7f+RvvA769JK9QkK9a1n///yVT69DDvUm40aFzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eUMLJI6aWslXKtzjUUelBLXuO54eM82Uxf0FIOMGv7c/XS++UayYe7lzfsncAf0Ep
	 /PrhHugivdlvt3E75t6rlpLHK471YMIHm80KY634DgaJe4WWsW8XKLHbuGZV3a5+3K
	 n75MquDxTnSl7VND/vPAQ6oMZuiHayTRW7rl0CQeKNFFtRnVoiMzVYGXrwn0icv/Q4
	 oIdd0MY+NWjxY9w60Gl31077oojiwuCxlMJKxXj85qRg6oAT/JSQBZNRyCF6CVaPZg
	 f7IvLYD0QDDvDnrjIpBKQR0vqfV8/2COn706heAFPZNnzFOhKcmdvhQyy0gSQIi7wr
	 GinT4za7oOIoA==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andreas Kemnade <andreas@kemnade.info>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0efd8e9de0ae8d62ee4c6b78cc565b04007a245d.1731430700.git.mazziesaccount@gmail.com>
References: <0efd8e9de0ae8d62ee4c6b78cc565b04007a245d.1731430700.git.mazziesaccount@gmail.com>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: bd71815: Fix rsense and
 typos
Message-Id: <173392131040.792872.4075640158285084340.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 12:48:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Tue, 12 Nov 2024 19:01:06 +0200, Matti Vaittinen wrote:
> The sense resistor used for measuring currents is typically some tens of
> milli Ohms. It has accidentally been documented to be tens of mega Ohms.
> Fix the size of this resistor and a few copy-paste errors while at it.
> 
> Drop the unsuitable 'rohm,charger-sense-resistor-ohms' property (which
> can't represent resistors smaller than one Ohm), and introduce a new
> 'rohm,charger-sense-resistor-micro-ohms' property with appropriate
> minimum, maximum and default values instead.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: bd71815: Fix rsense and typos
      commit: 4341de296cfb2c2e46bd770ae1c94867d6c97bf2

--
Lee Jones [李琼斯]


