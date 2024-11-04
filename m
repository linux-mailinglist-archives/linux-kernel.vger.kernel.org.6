Return-Path: <linux-kernel+bounces-395412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D29BBD9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7DB1C21002
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011DC1CBA1F;
	Mon,  4 Nov 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr4xnJjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517A7E552;
	Mon,  4 Nov 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746997; cv=none; b=qMXtUYNfQpuJg8bDQWG/A6C9qeoNzt+WzFsK20RnmX3nd2RbtjuuwItdUpg68YmThenIGIPm0aw9zc3snLYLKFZgclB5ErZTgbKLLCrcDyAVe4e23oNpZSrZj8+M8q4oPEszRh3HgFaVdQm0m0yZJCuBom/JGbaN8jB8zVOehDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746997; c=relaxed/simple;
	bh=3r1E4jlJB4SLcbXZTrwJvyUumCnga/Bf9P2eoxkAa1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kp0HhCEMWAXOJn9H7sYHbIJN+NB3Q+QQPROyHQ0vkWNgfbz5l2+a5sjWStrDud3J1fGRmIoELwFbf8bMf6keExS36IejaITKkmfxKivI+mmZhUafsTDrMSVgCPSYlnL72LhCcXaMYbv+/219fzbBBKsy/i54v46WI5GPFGApWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr4xnJjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69DC4CED0;
	Mon,  4 Nov 2024 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730746996;
	bh=3r1E4jlJB4SLcbXZTrwJvyUumCnga/Bf9P2eoxkAa1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mr4xnJjNlzjgQEcOHb/8xwXRzqZFAhsVuBIKZ2Clp6ZbOR6fkLm/drcc0ImyQ4ObG
	 N78GCyjslMDBjxJhwyZ28Oqwzp6SGzU+J1TiTkBHbt+Dx4AWUR+wwwDlDuwlAz6o/M
	 nL2u6pT20zkxEejTkM6OWVJfRen0JOHSdrzIgiZ3DqsJlPGLUIBXmrVCNgnF17UYQR
	 IrEpfpclIOPlWZNMEO3NAuYD7ZU8mnGcjPNQFwbQ5EUeqzJZV4CGkNBUHRrtL/wTeD
	 YLirdsTapUiet/BNrNvkuq9J1pzE6qykIXQb8BKL23dQnd5Y0s7PdN0zKnVUYnWv3B
	 qtYPoFpqDn4Ew==
Date: Mon, 4 Nov 2024 19:03:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: actions,owl-cmu: convert to YAML
Message-ID: <20241104-lend-lark-ab46a268213a@spud>
References: <20241104153108.3053932-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XOrBdxecZKGerwZn"
Content-Disposition: inline
In-Reply-To: <20241104153108.3053932-1-ivo.ivanov.ivanov1@gmail.com>


--XOrBdxecZKGerwZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2024 at 05:31:08PM +0200, Ivaylo Ivanov wrote:
> +    soc {

> +        #address-cells = <2>;
> +        #size-cells = <2>;

FWIW, you could drop these two if...

> +        cmu: clock-controller@e0160000 {
> +          compatible = "actions,s900-cmu";
> +          reg = <0x0 0xe0160000 0x0 0x1000>;

...you dropped the 0x0s from here.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--XOrBdxecZKGerwZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZykacAAKCRB4tDGHoIJi
0n0GAPkBL2R9XB/l1IMWxiCtryHJhv5Az3c5Ns/wRAlZQqj2eQEA9fvaT5wEeqmS
HYIA2tKZf7xhQTbA+sdSQZ6HO3Qfzws=
=xDDY
-----END PGP SIGNATURE-----

--XOrBdxecZKGerwZn--

