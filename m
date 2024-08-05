Return-Path: <linux-kernel+bounces-274590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C002F947A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17DC1C21481
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718C15666F;
	Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="QnoumxH7"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72881155740;
	Mon,  5 Aug 2024 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857741; cv=pass; b=DiD9edXDdmo/JMVGdbYScpgLKZvjKUghq4S8eB5PUL+b6gGKweyhf6295QqK8HcXMWpPHVlTHDCTDD+57LjKru99ds6cbhSYstbisLUR/JIvcjwcn5nbhKGiM9uiU2h+0Zvo2dAdKLrMHhDMI27xOIqpEaTgGExDdtqXk3bBU5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857741; c=relaxed/simple;
	bh=aTfQaPgUYnAnCyFUn/5spSM/wKIQwZIArxndmplyzTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O+oTMxfmcS+S0/8ptjnyYufqmA7nTq/v4AxSXvtU1v/mU6/n/baLdeMPR/V4FeZhbn+1vlCj1Lgk38P0vxDIj7yc+i9MKTJi4dJma5KMSbbYLh9ExR7iZTUsL7rDha3ik8p8K947wVA1KIRM+e8EHL4AtqyES3Q21ojMJWRnVLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=QnoumxH7; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722857725; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g/GnvcO8TsPWGNycqtXHcNwpaKWPUgO+exdWsluW8aGDtbvOS9DQgXJBpZ48e8S3f91KIa1xycPzv9VAKvxWgihaJQoMszv+gnieR4JZ6oN41ft0UwOuHaNhz2pTYYCH89jHL3ehRKOzkLnmnpsyNsJd5RZ1AH5MqHpyfihx5cE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722857725; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D30+KTuVISNJkq8cu13QoORHjYLmp/rARmI7rVNmqNQ=; 
	b=R8mbq4TT5iq9+/+jYht3D4p0uCqjZTNi2uhXx4mO9GfgFGyw+zLicn+CCUfAyaLNH9p80I/14cMHulKrwNiQFcKvbsCTKNUE9BV5FE07Gk+bOd227WytT8judpLLo0zH5VRA4DyB++CzpqGEtTzI8J27w4gdxcC6DeTdprCXE6M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722857725;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:References:Subject:Subject:Message-Id:Message-Id:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=D30+KTuVISNJkq8cu13QoORHjYLmp/rARmI7rVNmqNQ=;
	b=QnoumxH7L47I55LMXxRQ4/7i/EyzMfwsellRfRc1xz8A8yv+7mUpmMKmrOK9A8Es
	W7i/QbMt4QphxswrzV0PB+cevZ0XZupFrBW0z7XVg3wLPDfM7GIPUZLiZIu6aGHxQqI
	jjWIgTrGfhjmO/uiiT0hwoyiSI9eGltk/nA/3nek=
Received: by mx.zohomail.com with SMTPS id 172285772333611.108724364058162;
	Mon, 5 Aug 2024 04:35:23 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20240803-mtk-socinfo-no-data-probe-err-v3-1-09cfffc7241a@collabora.com>
References: <20240803-mtk-socinfo-no-data-probe-err-v3-1-09cfffc7241a@collabora.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8183-kukui: Disable unused
 efuse at 8000000
Message-Id: <172285772078.117243.12486644003118718427.b4-ty@collabora.com>
Date: Mon, 05 Aug 2024 13:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0
X-ZohoMailClient: External

On Sat, 03 Aug 2024 10:33:25 -0400, Nícolas F. R. A. Prado wrote:
> MT8183's Devicetree describes two eFuse regions: one at 8000000 and
> another at 11f10000.
> 
> The efuse at 8000000, unlike the one at 11f10000 and the efuse on all
> other MediaTek SoCs, does not define any cell, including the
> socinfo-data ones which the mtk-efuse driver expects to always be
> present, resulting in the following errors in the log:
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mediatek: mt8183-kukui: Disable unused efuse at 8000000
      commit: c24025e978780f0a82f859356caa00cdf20ab28c

Cheers,
Angelo



