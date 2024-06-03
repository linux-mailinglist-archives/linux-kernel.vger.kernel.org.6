Return-Path: <linux-kernel+bounces-198792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C58D7D77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6091C2223E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9137640E;
	Mon,  3 Jun 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="gIbqLe0e"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D95BACF;
	Mon,  3 Jun 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403784; cv=none; b=f68pdk4H1MXqblsz6gd6huDWARkPyEcE/Pl5Oioz0KNFfcUpyGxC+NAtsieTXL4LiwfgYX+7NjavyJgFxHNhrP6eVSMr+n4zW+UfVrt/ING8qBz5s6gUfjec/KRs2Ep6vZcsv8u/aWt+r9m1sOQV68Pj0IVovWo0P/VePuC9tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403784; c=relaxed/simple;
	bh=SGwxwn3cOl8zFt9eXkbF3zSBc4VgSBmVKp+8BzEACxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRyhE06YRyNwwVdJpI6tOEBHtOu4e/644vQAG8jFbpg+DiD+U7mfL9ZRFCPStGXnWl2/cjxRy2YdiPoVHbszHf51cdyfkFz1PE/hVsnRJraRFYj6RyL4tNafyir2etJ5kHKr+EWpIVF5NyiBOEnlEkH7kC+zOMJJW4FmUe/SA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=gIbqLe0e; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 68B791F9E3;
	Mon,  3 Jun 2024 10:36:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717403773;
	bh=9ZZDZ+bxHkd4WidkWmCQRH6wA+PqO66eywpfwGMP14k=; h=From:To:Subject;
	b=gIbqLe0emVKFLpueRF5AUeYxoTOQrEdXnAKRoGsm+T5sb86OZD64US9/I3ld9nbBh
	 lk3wvea1BmyC7wYuUgvdIgTkyxxUMYL01KJ/kLiRCucMwWfm5RZKYKM3ZBrIxuPr8v
	 U72JRWYcnf/Oa4HPkt0eh1RS5kQGYqSry+WgRtIYNfv48u07K9Mz4cG7Ln4MN05jnV
	 JV3R7yRXU8JAUNpczhLfTvqZRfDry1qSN3YuijPMGbmZ2fAYVhjUkhILfFLT2i5r6J
	 5OabgTXf2jOH7uoMoaSbXmNmgE9Qj4je/3ihP4gms0iWz2cyM13zAuStlQp7JUiJtI
	 Pt37eqrV15afQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: gpio-sbu-mux: Make 'enable-gpios' optional
Date: Mon,  3 Jun 2024 10:35:57 +0200
Message-Id: <20240603083558.9629-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603083558.9629-1-francesco@dolcini.it>
References: <20240603083558.9629-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The enable gpio is not required when the SBU mux is used only for
orientation, make enable-gpios required only for alternate mode
switch use case.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - add Acked-by: Conor Dooley
---
 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index 88e1607cf053..30edcce82f97 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -44,13 +44,18 @@ properties:
 
 required:
   - compatible
-  - enable-gpios
   - select-gpios
   - orientation-switch
   - port
 
 allOf:
   - $ref: usb-switch.yaml#
+  - if:
+      required:
+        - mode-switch
+    then:
+      required:
+        - enable-gpios
 
 additionalProperties: false
 
-- 
2.39.2


