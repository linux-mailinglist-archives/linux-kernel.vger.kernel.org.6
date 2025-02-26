Return-Path: <linux-kernel+bounces-533596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7355DA45C76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74DC216436E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27718CC10;
	Wed, 26 Feb 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b="Pqnuy1cd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D342AA5;
	Wed, 26 Feb 2025 11:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567733; cv=pass; b=JbkWs1FYwOYuQGZQhnHFla7+r08ChMdQp0HsLGlkpZmFOMzjGz1EqSKwtPQm2C4/z/5eSmIrvfZpXlMX5xF+q4Opa5aCamc28IChyh9kmPOobhxHOA6NAqcfrqhuruM0w5cEgFF5t/JiCacmb68YnzA7y3ShZDwvz5672ICNuRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567733; c=relaxed/simple;
	bh=PFQ+EYK/8O8aCGX6DneukYkRMliA11MfeP0OGf/4Nhc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KuWwB7r6vrxGHf2Au+I8VaNtj9fCNq+JPg4SfEWb3OpsUUZstHzsHQtHX0qfxo3XMUFh7o8JtEh4SqK7qJqpDZgEtt6jC3A+pdUbM+u3swxd0r+0hbbe/mpWOruRvNhwxcFihzNgwgVuf4uMd8ffAFgCJ2649qWo0+U1yiQ3HKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=louisalexis.eyraud@collabora.com header.b=Pqnuy1cd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740567688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OHsDb7qi1Q6V5cXXa+YwxRDw8cJL6/TX5DzDe+cmvdZmYIUxkaQlNlknKCAZYLlALZqtbBA67LDbcR8LX0SfCCV9GF3bbiDMCfulZHfpK9K+Rg/zb8OIyjTBVaIJ7awcqkjSmrcb4khM3tIKQaAJTeIwtUXLrSG7v9FEaZJncS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740567688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PFQ+EYK/8O8aCGX6DneukYkRMliA11MfeP0OGf/4Nhc=; 
	b=EbOZIp7auPL055mgS9OAypJ0Me3pj7acA7q6jcB2A5IadsDoALo/FLmB/w3f9mnXL6ajBSPqevKRNUYf7VoOvenM31LimL8CNpIXtA5aPwm7+K9zQUQcP32dmtGgWqLoogINjpETwjYFp7Ie64tNDij6VOqdPrprlEqSVNkUMCo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=louisalexis.eyraud@collabora.com;
	dmarc=pass header.from=<louisalexis.eyraud@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740567688;
	s=zohomail; d=collabora.com; i=louisalexis.eyraud@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=PFQ+EYK/8O8aCGX6DneukYkRMliA11MfeP0OGf/4Nhc=;
	b=Pqnuy1cdlVxfvgCICDSklrgS9RX7RbAtLq6CNEwg0w7lWu1hVbp11s2h9Gp7+n1u
	pBDTlMExaN1+A1dUef26MN0FZ6wXWlh4Bd5k1aj+oeZ6GQHX38JUK4k4bImN0dxsWbN
	99H4QJjcunoe7QNcf/etCvN/Vb5cCx1IbIYmbMUs=
Received: by mx.zohomail.com with SMTPS id 1740567685853948.6812241070395;
	Wed, 26 Feb 2025 03:01:25 -0800 (PST)
Message-ID: <3ec81e9083afae19f672afed3809ad5db20f7d9a.camel@collabora.com>
Subject: Re: [PATCH v2 0/2] Add driver for Himax HX8279 DriverIC panels
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, pablo.sun@mediatek.com,
 	christophe.jaillet@wanadoo.fr
Date: Wed, 26 Feb 2025 12:01:20 +0100
In-Reply-To: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
References: <20250218143952.84261-1-angelogioacchino.delregno@collabora.com>
Organization: Collabora Ltd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2025-02-18 at 15:39 +0100, AngeloGioacchino Del Regno wrote:
> Changes in v2:
> =C2=A0- Removed unneeded mipi_dsi_device_unregister() call for secondary
> =C2=A0=C2=A0 DSI: as the driver is using devm, that's not necessary (CJ)
> =C2=A0- Removed superfluous if branch as pointed out by CJ
>=20
> This series adds a driver for DSI panels using the Himax HX8279 and
> HX8279-D DriverICs, and introduces one panel using such a
> configuration,
> the Startek KX070FHFID078.
>=20
> This panel is found on the latest hardware revisions of some MediaTek
> Genio Evaluation Kits, and specifically, at least:
> =C2=A0- Genio 510 EVK
> =C2=A0- Genio 700 EVK
> =C2=A0- Genio 1200 EVK
>=20
> This driver was tested on all of the aforementioned boards.
>=20
> AngeloGioacchino Del Regno (2):
> =C2=A0 dt-bindings: display: panel: Add Himax HX8279/HX8279-D
> =C2=A0 drm: panel: Add driver for Himax HX8279 and Startek KD070FHFID078
>=20
> =C2=A0.../bindings/display/panel/himax,hx8279.yaml=C2=A0 |=C2=A0 74 ++
> =C2=A0drivers/gpu/drm/panel/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/gpu/drm/panel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panel/panel-himax-hx8279.c=C2=A0=C2=A0=C2=A0 | 905
> ++++++++++++++++++
> =C2=A04 files changed, 991 insertions(+)
> =C2=A0create mode 100644
> Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
> =C2=A0create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8279.c
>=20
Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> # on
Genio 510 EVK and Genio 1200 EVK


