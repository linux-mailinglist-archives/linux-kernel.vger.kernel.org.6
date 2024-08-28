Return-Path: <linux-kernel+bounces-305303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E0962CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063BB1F25ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091D1A257A;
	Wed, 28 Aug 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O3W7b2tF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bu4hQFmF"
Received: from a7-43.smtp-out.eu-west-1.amazonses.com (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D183A18;
	Wed, 28 Aug 2024 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859772; cv=none; b=IjxDFOROGpFu2klge+pQv9IQ1OEZfbOsKwc+YbKUTg5NnDgPhUQduZxlvdd3opABOGQYN2Za4KMWACy2Qk/JbliIvS6/EV3XA7FJb/PbX+JTVbsnEARMQ3FaSYoyJ0AuXTGsaxssdcqGTROhWFe0PDGxpl8N9SFGYoFcoeKxxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859772; c=relaxed/simple;
	bh=xvS7mUpObgNa0y44bNiTQm/TS6jfEf1+p9f/JF2fZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OXjpp7refB4+oWjwRyYHc5pD+bMX0v6nM4teHYjuK7Q2L8khZE39U5qz/fxHt/LsIoFCdycdT4UkhbUi2HtQWkkIQBQM8ixHAYKNXZQXCZW4IE5yWfIH2NV+kX/MYLGF6brzikS1bqfL5f1x1ntP3gqvL1m/HV03WrQdWmZMU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O3W7b2tF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=bu4hQFmF; arc=none smtp.client-ip=54.240.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724859768;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=xvS7mUpObgNa0y44bNiTQm/TS6jfEf1+p9f/JF2fZJs=;
	b=O3W7b2tFPIArTnoTwpvggcVI7B+QHPVcjk2p+kSuNcNWX8qUsCJAwBH9oK+7xj8G
	rWuv+ZB3uEDOAxQnvPmcva/sfOJXpfTU04hcr3z0YKPbTpwgNGgpxNDBRyOiJ/YchK3
	pg+sq6MICMh38evtC4mxjTwHdzJreVNU+pp7sljRPzZhS1Dg7rcQ02kUgojJzYbNveK
	1bZRAOEvRVVv1Mj0xM+NR3qoxFlTT0e9yT9rCOVHw9rCeio+hojI9fYl3bATJLGxrAl
	behdh/BJUjq5axQmDNbsV1aMRbyovdIb39DIOEuJhQMVMvLWb5pnfAEcWUCKqV2HtHy
	w03vbxWQKA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724859768;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=xvS7mUpObgNa0y44bNiTQm/TS6jfEf1+p9f/JF2fZJs=;
	b=bu4hQFmFlsZiszzltCIyxjjy13w3RtbJmRZE2ryjF8y0kpr1vAC0gZKlTWCtbzbv
	iuGC1k/0cDipVqUD1PtM2eAuE9nXWS7Im78IA6jVjO1VkEngX8BIqvWk1rG1JZDX4Em
	MFL6U9vzbFW8XxELouQljBPIKbaQvdps84zCWX0I=
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v7 0/3] Add CRU support for rk3576 SoC
Date: Wed, 28 Aug 2024 15:42:48 +0000
Message-ID: <0102019199a75f9b-aab57db6-806a-474b-8295-e5be5a99d424-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.43

Add support for clocks and resets on the rk3576.
Patches from downstream have been squashed and rebased.

The resets have been renumbered without gaps and their actual register/bit
information is set in rst-rk3576.c as it has been done for rk3588.

Also add the pll_rk3588_ddr pll type that is used by the ppll clock.

Changes since v6:
- Renamed HDMITXHPD to HDMITXHDP in clocks and resets

Changes since v5:
- Use mandatory syscon lookup instead of optional grf phandle
- Add pll_rk3588_ddr type to always have correct rate values

Changes since v4:
- Fix commit message with idx starting at 0
- Stash all bindings commits
- Cleanup example and add me as maintainer

Changes since v3:
- Add missing include in bindings

Changes since v2:
- Renumber IDs from 0
- Commit clock header with clock bindings
- Add missing resets on sub-cores
- Add redundant fields in bindings

Changes since v1:
- Remove reset defines that are probably out of the main core
- Separate resets and clocks bindings
- Renumber the resets without gaps

Detlev.

Detlev Casanova (1):
  dt-bindings: clock, reset: Add support for rk3576

Elaine Zhang (2):
  clk: rockchip: Add new pll type pll_rk3588_ddr
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   56 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-pll.c                |    6 +-
 drivers/clk/rockchip/clk-rk3576.c             | 1829 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   54 +
 drivers/clk/rockchip/rst-rk3576.c             |  652 ++++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 +++++
 9 files changed, 3760 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


