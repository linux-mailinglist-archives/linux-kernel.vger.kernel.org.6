Return-Path: <linux-kernel+bounces-325489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E653975A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5CD286B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04671B78FF;
	Wed, 11 Sep 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8OwxBl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911013AA36;
	Wed, 11 Sep 2024 18:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079030; cv=none; b=lT2XgacJYt7hLLL+ZWZH5FSNTmB3LPk87GyMmGTIKfKWQw8Qu97L4usCUITdGNYCJDCXi+O8oJsld1SrsIZkERVHscv02pb4cSDooAjIvCwhmho4hlbu7zgLiJg40Bs/yeuXfRxJnN2JAKlSW2ywq4fMBNvOwMHI2epeTDIc05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079030; c=relaxed/simple;
	bh=QlVafWfsxXe64iPt3DsETvgIcbWeObtPdAuH2D6kkcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDN8w+imlSNK3t/+OCoC6CUMrQNKVZ7vEIj84dJ/IAenao9bcX3rP4o3Yl+1bSQhTAxS9YEnq9gPVtJ2VH43wrEyzIMpvN7eKi/J9GGDkZsAKBddFkgjaTvtbhlBWpnKFYcnqYEFTSDYRQSa7W0PkVMmBiMZ8s1ms7s+u5FB9Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8OwxBl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17D6C4CEC0;
	Wed, 11 Sep 2024 18:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726079029;
	bh=QlVafWfsxXe64iPt3DsETvgIcbWeObtPdAuH2D6kkcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8OwxBl7xhtdnajCIg7yeTzX8AkbrL0Tdpm0/VGkBp314UDYPDH7mwjUwuRtAqrW9
	 04Msab4jSX2BruM8gE2umSUM+MMTAm7LB7oGvACp3HcOr5rSO0g0CxUBwB0ZTR+8nW
	 Ov7iKpQGvB8pmuYBMH3Z5ZN/NGDpKi1QB6SoyVrG7hi0T8sJpZ9/wsGHZGcLTzSDSs
	 DViwBa7SAneZ9QtCMxsIS9WhqObbx8C4VHQK8FTIrDfkur6xxDg5/DR9vyNb6f1tbO
	 XoCYgxnFReCSTHLSyfmSDGb79ZtNUqnWnG4Dd1KJvywRoeAn4Ol88wl86uVebYXjfC
	 Hy4vuiDN2MgwA==
Date: Wed, 11 Sep 2024 19:23:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, macromorgan@hotmail.com, jonas@kwiboo.se,
	tim@feathertop.org, knaerzche@gmail.com, efectn@protonmail.com,
	andyshrk@163.com, jagan@edgeble.ai, dsimic@manjaro.org, megi@xff.cz,
	sebastian.reichel@collabora.com, alchark@gmail.com,
	boris.brezillon@collabora.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add rk3588s evb1 board
Message-ID: <20240911-phoenix-backboned-68197e59f8f2@spud>
References: <20240911022930.4022802-1-damon.ding@rock-chips.com>
 <20240911022930.4022802-2-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yeSxzhvePg7FXNw6"
Content-Disposition: inline
In-Reply-To: <20240911022930.4022802-2-damon.ding@rock-chips.com>


--yeSxzhvePg7FXNw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 11, 2024 at 10:29:29AM +0800, Damon Ding wrote:
> Rockchip rk3588s evaluation board.

Please try to write a more complete sentence here.

> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

Content of the patch is
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--yeSxzhvePg7FXNw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHgLwAKCRB4tDGHoIJi
0mRhAQDoEx0wkR5BEUQU37l704W+uKuFO4zHU81++H170l9pqAEA/rCPh1hbruAR
sBIvbLNbCCjerF3bFJomu6MdzR0nZQA=
=sKRd
-----END PGP SIGNATURE-----

--yeSxzhvePg7FXNw6--

