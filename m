Return-Path: <linux-kernel+bounces-576593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DAA71182
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B43B64DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F319DF9A;
	Wed, 26 Mar 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpOOq0yg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA17519CC1C;
	Wed, 26 Mar 2025 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974891; cv=none; b=dc7e7DGZB8J3gEo74yzWdQTrCx60r7FZAHdaseonF4LGH3Gj80h0WnhT6g7czIsjR0wPHx/uqqG9JzeHXkGbxzZgalYYF0QOxlahSQg8NeFyfg8bkVLyiQ0rtYkUcKdEPCGb+fyKe2woQkSxMS8TlDasKaqyR+J6NyYMzq8/mFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974891; c=relaxed/simple;
	bh=rBYoJUxPomzvyzOlBrsF+JK7muFZEKCY181Mv+AYWD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY3lRvrrW3Nl+Tqh67lqCHo01LQ5UDjyPIH8iQmnJla1EIuuLDozfEGE3+FG0u2BR9ha6hKGEudF8Vy5tlblTlPAJh7igGfLnNW+oBtx8QrjX4lkdMewOzBEjRaXPljHX1Quu/9bM1sPKkxNUyvsdJPSQUPHUggrN4wZNjSGVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpOOq0yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B83CC4CEE2;
	Wed, 26 Mar 2025 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742974891;
	bh=rBYoJUxPomzvyzOlBrsF+JK7muFZEKCY181Mv+AYWD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TpOOq0ygoWcU+9ocYUPGZPUHhxtn7eYhnGmPnuOuG3IwEkoYzdj2ti1l9Q75EpHxy
	 yUs43wWCbgNJe8CEq/f4QX/EPR6V0R6ekwl9MrULXZjhvJc46Ha4SHKH9GjqwzV6+F
	 yLBcG8p+aOpkShjnAE59Rv+C+YmEn1wXyS0HZhfUsOKmxmhADnQjmUHk15Az6lPVNe
	 6oJoE9CX2q9QeCGQjR/Je8Qxz+zUnpjds4rFpuqSXmyiTfGE/bQXbQqsH4gr77eE9L
	 qapP6teilkDoP/l14TnPT5PG0krFX0EQ2mB+RVg73PTFz6yt2Sy1eqpChp256KBk1M
	 5R2rzlUd3poeA==
Date: Wed, 26 Mar 2025 08:41:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: stm32: Document Ultratronik's
 Fly board DT binding
Message-ID: <20250326-cherubic-puzzling-jellyfish-872ae6@krzk-bin>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250325110409.2323611-3-goran.radni@gmail.com>

On Tue, Mar 25, 2025 at 12:04:06PM +0100, Goran Ra=C4=91enovi=C4=87 wrote:
> From: Goran Ra=C4=91enovi=C4=87 <gradenovic@ultratronik.de>
>=20
> This commit documents ultra-fly-sbc devicetree binding based on
> STM32MP157 SoC.
>=20
> Signed-off-by: Goran Ra=C4=91enovi=C4=87 <goran.radni@gmail.com>

SoB mismatch.

Please run checkpatch.

Best regards,
Krzysztof


