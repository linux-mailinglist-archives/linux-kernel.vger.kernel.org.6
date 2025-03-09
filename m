Return-Path: <linux-kernel+bounces-553124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A44A5842D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68DED3AC5AB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB041DBB19;
	Sun,  9 Mar 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK+y3wET"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033D8BE7;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526186; cv=none; b=sRoKm6KRPN04p4aZ/WL8h3fLRSpPBO8fdbmqdaPmJHhIvIIy8V8fyeokusSvYIOnr5RACaeoCj0jMisj8MPqQRVgp+zmGSvuMJkcv/tqwEuLGyL78izhEjrQ7ftUfgZB0NAGG1fh6ygn5rns2XOmZMRS0XR5LeJO438+r/2euTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526186; c=relaxed/simple;
	bh=sXGqpc3WKcfHqTQx4M6yghIZTgooBtjzDEElH3FLBmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bJCOJlxVuEN0gv18qg90nl8DiJr86ITeHJ3j9jT2ekRsVjWiNYLBIA8f03fAshmczMiD8bvKb9yNmaeEoOzD5pD4prfTD/1a1UTktp2RxbHeOHKTuXogcrFTE8kI8sKO2gjAI4D615vxeMGZebV83B7jjepsuPgCsyI1HjhZoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK+y3wET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A0B5C4CEE3;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741526185;
	bh=sXGqpc3WKcfHqTQx4M6yghIZTgooBtjzDEElH3FLBmo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hK+y3wETfKuUaCbc/hMQ8VWmNA/RPIW66r4GEJ5NzoFph2CRWlzYtC9XR3rBFEdWA
	 FRXEJr4I1Or77IuIgs3NLOw8kiUXLmcxHOoiG7FkwGnrlYna245iPHBVtS9xDbQI1K
	 JIxMMnzhJft/NThTkXnqVIBu4BQmsc/B2T7wYbdy6obRSE/quqeBIzUJJ2J05tHiL2
	 rGGtNNtAJ2s4dpG24Jpmpw76AAl/gQMSAbODx+jvdx81/U8gFlZjGYy4xcfQAQLonf
	 9nQRynQo/vQCmc1GKmcFs7sG04vwWYbTYpsT2k9pKwjUr7oKC/Cf9DG4bgZNOA+KVv
	 z8A74AN9QDAXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE41C28B2F;
	Sun,  9 Mar 2025 13:16:25 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH 0/2] arm64: Device Tree for Ugoos AM3 board
Date: Sun, 09 Mar 2025 14:16:19 +0100
Message-Id: <20250309-ugoos-am3-v1-0-38cab5a4725b@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKOUzWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMj3dL0/Pxi3cRcY900M3MTQ2MLMwMTYxMloPqCotS0zAqwWdGxtbU
 AG099b1sAAAA=
X-Change-ID: 20250222-ugoos-am3-f67413860434
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741526184; l=789;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=sXGqpc3WKcfHqTQx4M6yghIZTgooBtjzDEElH3FLBmo=;
 b=KFqgJkbT9NIujlHGhFm/rVdGXRHTo5NcLMkJr6gLnbrM7M1MDwvekKDXH18GNow11O+DpCkYj
 KQdztzgUsbIC5N0WLj5HCSQuZdReN4kdb5XFmeI1g1pTIBmbYrG4Hfk
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds a device tree for Ugoos AM3, an Android TV box from
2018. Most hardware functionality has been tested, as noted in patch 2/2.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
J. Neuschäfer (2):
      dt-bindings: arm: amlogic: Add Ogoos AM3
      arm64: dts: amlogic: Add Ogoos AM3

 Documentation/devicetree/bindings/arm/amlogic.yaml |  1 +
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  2 +-
 .../arm64/boot/dts/amlogic/meson-gxm-ugoos-am3.dts | 95 ++++++++++++++++++++++
 4 files changed, 98 insertions(+), 1 deletion(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250222-ugoos-am3-f67413860434

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



