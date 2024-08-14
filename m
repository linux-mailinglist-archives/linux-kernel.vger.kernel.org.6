Return-Path: <linux-kernel+bounces-286345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3FB9519E1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867792824E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D891AED49;
	Wed, 14 Aug 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="G4twbP6J"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA131AE84B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635033; cv=none; b=L/8U0aYFtj6caCS8z6qlcGh5bsC43wpjH5jRHO0DH+BXgfz/Upq4ztFCF0nwpESRRACXeWU8+sTV10RqVrXPIUccuK3DWiD6/+p1kOuOy+EgjD8y7e1RNmw0nYdUM0D5J+BxPboRE6Tm+A2oXUlBTBwXyjYQhmxHcwF/v5LQtIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635033; c=relaxed/simple;
	bh=dP4bfrn5l3bdzoF3Sl1T7LFZ0IksHKCZ14p6q3YI7oA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NQQR9r3+Pkn5tgSgs/RzS5VDV1B86NY0jeghva/TW+X6E3q2Qiebi/AM9A0eGgycVPyVW/EahKgOS6+G87O2FMfBrF2ty+R02xcyTRuCMUCj0F8V965+S4mir8hwifugu2wWHkeB9Cdi+SEiCGi70PmgEpaTTJqu9cQC7NNsJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=G4twbP6J; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1723635028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dP4bfrn5l3bdzoF3Sl1T7LFZ0IksHKCZ14p6q3YI7oA=;
	b=G4twbP6JuI139v/kXGn4SCpcTW5bzEAEIvpdt6NSeUFEozxioUePvIdOKqsxUAvQMUqO2F
	FrrrM3cjQgFBE5lJ8JddLkQz202Wr18Ph4TWhhlyOA3Fj4WM6R28xQd+KCI2G6Ux1zl8D7
	dNkzLaWs0PF7fliMKCfj9guX4bOMnhuPZ3X1o1Gb4PMZSO+J5eBm24ZZUlcSnnQo4vd2oM
	RskMe8NWhVwYM/1n972pRWuPFF4DlJQFmswnBcW+hjtGykCeZrxXA5wMw419GLMxA46A8y
	GSfDZYGcAuhsoTGVEd71ajU7a/SaSSsfVfo2d8XfxkKowj0xC4VHJs/LBaWXVg==
Content-Type: multipart/signed;
 boundary=2230cd77cb85420e4ea04e69faf9ec868c0da4eaf62f7bd0825d5c64cdcd;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Wed, 14 Aug 2024 13:30:17 +0200
Message-Id: <D3FLMBPACMF8.249JV2GI2QGHA@cknow.org>
Cc: "Daniel Golle" <daniel@makrotopia.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2 RESEND] arm64: dts: rockchip: Add DTS for
 FriendlyARM NanoPi R2S Plus
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Sergey 'Jin' Bostandzhyan" <jin@mediatomb.cc>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
References: <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <Zq7LBqKVvVVVLg7a@makrotopia.org> <2309282.ZQ0cqP7t2B@diego>
 <20240814112138.GA21761@ветеран.su>
In-Reply-To: <>
X-Migadu-Flow: FLOW_OUT

--2230cd77cb85420e4ea04e69faf9ec868c0da4eaf62f7bd0825d5c64cdcd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Aug 14, 2024 at 1:21 PM CEST, Sergey 'Jin' Bostandzhyan wrote:
> In case you tell me to go ahead with a v3 set, should it be in this
> thread or not? I understood RESEND's should be new, but updates should
> stay in the thread, right?

No, a new series should be its own thread too.

--2230cd77cb85420e4ea04e69faf9ec868c0da4eaf62f7bd0825d5c64cdcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZryVSwAKCRDXblvOeH7b
bmGSAP9pY3YpoP4U50pQV1Shkwvh21J5/bpdqejppJ2armAa0QD9HzOqM8smiCRG
akUL19LbeMD4BmdZJzATIpD5hxaJfA4=
=lOzW
-----END PGP SIGNATURE-----

--2230cd77cb85420e4ea04e69faf9ec868c0da4eaf62f7bd0825d5c64cdcd--

