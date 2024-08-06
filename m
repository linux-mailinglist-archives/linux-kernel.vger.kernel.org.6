Return-Path: <linux-kernel+bounces-275843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ACE948AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F0A1F2104B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C416BE26;
	Tue,  6 Aug 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="UsxKHhmf"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268C82AF12;
	Tue,  6 Aug 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931666; cv=pass; b=GoTPErY/XqRo5Nt3R1EB59U9NkNxYV2RSXwRn/JVd1ZtVAB3Zz4l5Ch9bN6wLfDkULEQIBWOTbb815jlXnzExQwHFDBzGQcg4tmGirBm0ow0rf7xELcyGEAS+dfO4/ENxyaGK7/VrxWW94aGPsIDUucyixyoSZcgUJYNfJXG4EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931666; c=relaxed/simple;
	bh=bwQKidI9pODrIEYPmfbCvwKKsalCr8dYWC/jTO11S1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hIrU5cQCBpijiIUAJhD+1gn5trnGrfzlxI+opkxUazcJAQoLyNYK3q+dUZ5RvGc7pIPg+m7jPooItVmuSyfI7uk4fkG+HfihVjBbrQpgfqjHqedsuougtNRLVIiURFL1bHUQiTDe3kYAykV4/WMFetfv4ZV+UcLtxMydtW0EN/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=UsxKHhmf; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722931658; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N2e1lk4kfrhaRAtgWbQXJRPDt1ynW5cjnde2J8ZysRQJUAOwqDdoiAdewFHCWjNhJEocwUPao313kYJ+Mmi56n3OPAy5jHX1WiBXpc4H8lT9L3hSxbESAjQB1ZVCknPQ5lpKNtivDR9p6qfTxgB15jq5iSb1VXgz2xGzAng372E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722931658; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bSU/7Kz+oEIpxKjEzwo61RqKAafjCLDSroZXQNzm+mM=; 
	b=PtzAXx+xwWGfy8n8MXnAcQHgDt+/Ap8wp5OOgQVXQBp4DlWEhu+pBRAd4D30EJzq0/mzh351q0k7OoA19WMEtHM4qaa5IrM+gr0ioP3ztz1zY4jlKWMcOSEMrA5VvhyIgnEyuNQ2AjoDho41kUStlW2E4wggMYm8Uv3cavmH5+E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722931658;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:In-Reply-To:References:Subject:Subject:Message-Id:Message-Id:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
	bh=bSU/7Kz+oEIpxKjEzwo61RqKAafjCLDSroZXQNzm+mM=;
	b=UsxKHhmfa6m19Dx1Hg90C9Ui3kMtV+xHQlf+B9NCEbbPjLwn/Hb8h+FSbGhJCmmD
	lS6SFz+2HQ+g1PrVGoNc9rxjnLilWpB+/gwDmEzPPhCKPZABzE41E6mVHPZzO3Y1SwU
	FZonMjhtDqjUH0TowkmUi2SLJxiGf1UNZ4pdShak=
Received: by mx.zohomail.com with SMTPS id 1722931656834676.9532817394971;
	Tue, 6 Aug 2024 01:07:36 -0700 (PDT)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240625095441.3474194-1-wenst@chromium.org>
References: <20240625095441.3474194-1-wenst@chromium.org>
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: clean up regulator tree
Message-Id: <172293165481.46149.12368879686778657908.b4-ty@collabora.com>
Date: Tue, 06 Aug 2024 10:07:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-ZohoMailClient: External

On Tue, 25 Jun 2024 17:54:38 +0800, Chen-Yu Tsai wrote:
> Some regulators in the kukui device tree are modeled incorrectly. Some
> are missing supplies and some switches are incorrectly modeled as
> voltage regulators. A pass-through was incorrectly modeled as a
> regulator.
> 
> Add supplies where missing, remove voltage constraints for "switches",
> and drop the "bl_pp5000" pass-through.
> 
> [...]

Applied to v6.11-next/dts64, thanks!

[1/1] arm64: dts: mt8183-kukui: clean up regulator tree
      commit: f5843dc83583d58e13e6851c70ad8371f036dc35

Cheers,
Angelo



