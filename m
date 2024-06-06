Return-Path: <linux-kernel+bounces-204654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB3B8FF1C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35701F25E87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8881990C8;
	Thu,  6 Jun 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7+WvXZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5981990B5;
	Thu,  6 Jun 2024 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690175; cv=none; b=fVRJBas+qQQf8yWNogo4ZkJ9i4ph3qmofcQyEzt7SzanRFyj+Z28h24ADnCAiz7OCVm5HAcjqcn5MDCAJBKIqu70B23wG7I+kzzkel5dAa3F7HwwYF3DAlGCIoV/lIMZ5bQoWriNy3aHkZ/AORcWkUKImxKDIpC3WZzBb/oGEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690175; c=relaxed/simple;
	bh=Y1FSBBDktAab0PFUzo939Grq4Np65U4h7zGSymdlWNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTRQefAeu7aVaFtx1vjQy0DlCPEahOY9mq6R1s/LXVsxyYmd838QSK0BAC8K4cp/XQcaKe+EblXBdDPv51jBahP2UjAzp5cNGq9zcQRlkjMgA3ogcJlXua7Z++PUI7NT3KqwF9ATQDX43DT73wn2H0Z3iJFrKn7E0cx9HFECFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7+WvXZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA4C2BD10;
	Thu,  6 Jun 2024 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690175;
	bh=Y1FSBBDktAab0PFUzo939Grq4Np65U4h7zGSymdlWNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7+WvXZ5MN6Afpj3/aCgcCbfucfC4eknHYJFO7H8w8+oHVCbRbuK2xt1OXm8ScUNE
	 8cqhN296vT0hXcwAmOJ7+APtaMgyo7tAdBWc74r/i7mZySygQKUDK6JzrM+aOv5mdl
	 zWVZGgHgcV9QByA3GFV7IZjr6INxXVForKcqxpRMvnOj75LlapxDQZ6O1NPYoXBAWX
	 1gJNiGQW+Xczch6ZSw8lg5wG+dlHBXRR9ZMI69+vE9w4CREiyV1F+lKSinnzADQN/7
	 TX5qZvHSnzrcfvyDJKdb7/pjryXYykXdKW4magflnPUPKpDcxm6rZP8ZYNyIcR/Skr
	 X9Ckn+sZx5neg==
Date: Thu, 6 Jun 2024 17:09:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5 RESEND] dt-bindings: clock: rk3128: Drop
 CLK_NR_CLKS
Message-ID: <20240606-dispersal-buffed-27a6e7540d4c@spud>
References: <20240605210049.232284-1-knaerzche@gmail.com>
 <20240605210049.232284-3-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FGgIfamJBCS86e7A"
Content-Disposition: inline
In-Reply-To: <20240605210049.232284-3-knaerzche@gmail.com>


--FGgIfamJBCS86e7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 11:00:46PM +0200, Alex Bee wrote:
> CLK_NR_CLKS should not be part of the binding. Let's drop it, since
> the kernel code no longer uses it either.

What about other operating systems etc, e.g. U-Boot or barebox?

--FGgIfamJBCS86e7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmHfOgAKCRB4tDGHoIJi
0qlIAQDozQlHl2khmv09nvKM+QpHUNjjvRIOFTm/lWr50Grs+wEAnAI+XEvELGi9
OJrYfVp3WYbfWtOMfAmKx5KoDCQ4lwI=
=1vL8
-----END PGP SIGNATURE-----

--FGgIfamJBCS86e7A--

