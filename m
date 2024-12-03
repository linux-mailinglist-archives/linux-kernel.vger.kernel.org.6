Return-Path: <linux-kernel+bounces-429883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674989E2BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43300BC17E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB541FBCB5;
	Tue,  3 Dec 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyW7aAvf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4D1F9F5C;
	Tue,  3 Dec 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244610; cv=none; b=cmzxEnJAditD9S6Cu58+hGrzkbXH94KVNjXue7fKVqp7n4F2jeeO6qcr2hNWSttWbFK9Gv4riBy9BYANnJ0jNZrpIGn42I/j1A1vfvP49n7dnW7NWlJyYkgWWC4geAyidsv7+E1lL/2YnRkdB8OOjbN26/uX0uujEgj8mM3WrfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244610; c=relaxed/simple;
	bh=hl4qjq6wBEq5/6rBW02XlLyDQNXhu4x9H//HnoHXZC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI00WfWQCmml1u8T6wsSfNMX8/Lj+4uj1A6BPF67MR7cwl2BTLE7gX4Vc/8WCUPLxI/7/ndZACJsYrAxRV+ZFqTTUb7zDXriScUKrkz5Bul4dzJsPVIi4Jve0TGdRBOVROzCNUVlrcDsX4/FwomQ5DXaJItULCJO3ZimX/V1dGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyW7aAvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE083C4CECF;
	Tue,  3 Dec 2024 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733244609;
	bh=hl4qjq6wBEq5/6rBW02XlLyDQNXhu4x9H//HnoHXZC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kyW7aAvfsRsd+goXqPtxbrF2GZ9SUIgO8a/u1AJ8BIEnmbS5M3rvY8PwauYRqY69E
	 wMH5EFRYngFm5G+VV1tipxqdIFc41sJlBO0qh3qPCzE4sbfpkOA5o2Vyiy1qWqgIFB
	 tDM8h/jaa0EONYCKZBgvbq7BzhmLostW8/EjWPzgZMtsAzVQxFUDMqN0NCdgm9ZDLg
	 4fb6XRDcTbDHRJQdleIIvXoILAqO8mFQ9vF1/QKq2tdmUJNpeYz4vXfsC5H4pgkF5H
	 yXF+ZFN/xAJAxY7eBbV6DIDQiMKdXO9IDBGv7yUgvqUy0TKwnw3Vi60mUCL2qMjhMk
	 nZROfofiKrMYw==
Date: Tue, 3 Dec 2024 10:50:07 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
	airlied@gmail.com, mripard@kernel.org, devicetree@vger.kernel.org,
	ck.hu@mediatek.com, linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, kernel@collabora.com,
	tzimmermann@suse.de, krzk+dt@kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: display: mediatek: Add binding for
 HDMIv2 DDC
Message-ID: <173324460711.1946104.15731375026648249870.robh@kernel.org>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
 <20241120124512.134278-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120124512.134278-2-angelogioacchino.delregno@collabora.com>


On Wed, 20 Nov 2024 13:45:06 +0100, AngeloGioacchino Del Regno wrote:
> Add a binding for the Display Data Channel (DDC) IP in MediaTek
> SoCs with version 2 HDMI TX IP.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../mediatek/mediatek,mt8195-hdmi-ddc.yaml    | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8195-hdmi-ddc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


