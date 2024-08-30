Return-Path: <linux-kernel+bounces-308776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822629661A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50231C2344C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A0199FBB;
	Fri, 30 Aug 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k27Qnlml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3480192D95;
	Fri, 30 Aug 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020879; cv=none; b=Apd96tDHlmDfXyw6ZiAXyueTEXfKvEXwoD9r3FzVzDQxfSOlkBA9meN0Z7gq1ksRJ66i2HDEwKEb84tmX2ApCAkabFHnnI6fr6rw+U6GCsJCoDS210lVbKlMbyBodZChgqa0kcg6dyyLEZcQ23w2zQBbt6cWOxI9SWO8nCXa75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020879; c=relaxed/simple;
	bh=Qv3PljZ0K9tSka2ZTwGzebPtb9WGtHhBrtQHmVgyQb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=luxT4iKl/7gbLA5JFahgU8WOoZ1V0GNx74UaklKkdgddvFBsqg/ZDhoLTNX8nPiTsU4/g1oQ6VnxiAKPVb4SOsUD6sh6tdViQeB0WXD20eIgCHj3m0Ig9F8tOXVDewvE/K1bs47pm0I4RlxzljQmTFt3BfEtvPgxQZjCXpV9lUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k27Qnlml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC0C4CEC2;
	Fri, 30 Aug 2024 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725020879;
	bh=Qv3PljZ0K9tSka2ZTwGzebPtb9WGtHhBrtQHmVgyQb0=;
	h=From:Date:Subject:To:Cc:From;
	b=k27QnlmluJrrumul7FRNB5J5I0g845ic8Xn2z126p8zup49FwMYqwe9vc9PRJhQoO
	 QkTUe9ZZYQns96OZpXt6YYt/v/sP2iy0Sz40EejBqmFC7LSAFZU7lOhOOi0cuXTIN6
	 K/BaKQgJLFUxc6fLqRZEaYXw1h9caqUeNhnZtPs5yW5txvG1oR0TfM3SOWbpFlkSwc
	 Uo/ryL7bU90DNgtYrQ9PhVOJ6iB4uQj4tF0xw10EWqVBcmaAZBk8DvTezikW8PQpdT
	 ZZd9dxH2OGp2tziIz6z9OJ2JwjXAKMSQc4RkiSG/LIDLtVnMy3U66hITeVXXeZxBEZ
	 53vh8RC0Paz+A==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 30 Aug 2024 15:27:53 +0300
Subject: [PATCH] dt-bindings: mtd: ti, gpmc-nand: support partitions node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-gpmc-dtb-v1-1-792cac1ef3cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMi60WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2MD3fSC3GTdlJIk3ZRUo+RUI4vE5LQkMyWg8oKi1LTMCrBR0bG1tQD
 fn2VaWgAAAA==
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Nishanth Menon <nm@ti.com>
Cc: srk@ti.com, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Qv3PljZ0K9tSka2ZTwGzebPtb9WGtHhBrtQHmVgyQb0=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBm0brMkt5XayPMdgB1M2Au8oX6WERcC3svX6+Ui
 1xN8sYJgRiJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZtG6zAAKCRDSWmvTvnYw
 k1rcD/42JmCN4RRQBkVab/Oeo/gA5UdqT+rN6fmdU451xq2gkLQg+IuAxSSdS5Rr2d1Rb//WpYO
 60haGbAyyrSCq54JeK95wADI3JftE1NlHRzqYHy636GrY9laQw2BH2Y5cqlJZ7jqvmcWxJYvjSx
 rJ3ormDDq/vLPyuKy+LdQ0wBrq4QmscXZFBtw6ai5h1/vhn/dSAHdP1jwAxkVlqeAtOF2iTYGYW
 25QGi5XBsSuvhm1Hz8yTCYdkdrSJKtMRY9FXDvBF0B3DSOlF6beDcie1nD5p3XNuYwhEVuBjYd5
 qkkLRl96aChrUNX0AL41fwH05nKJzAF1U7nmJD4HCcokiOeZJmLH6nCowiXE3RSmnenQxvG5M9F
 JZMF6VRLohpwZ+G8zrTUzmPxoT/3Q9W5S2E2wcywCozjspbMDlY5Ex5yJoilQ+e+o7d8RBQ6tnV
 1Z2v2oM8zEjsweayV9iRjcdxYW7bc27ABNai8vQfD4MOWk4Z6jUQvFZ/LoLdtWZYOqe+gKY9ld2
 Oj9IA83EcEJYsVd5bZlCAFxQLrwFhYT+WCZ4uH8dXaMmw1yI0eum1kC1dRhdKVRyqKRirPti5Ic
 u5UEAJeDbldc7+n8aa8unHcWR21z3PdUf2FnNk654+Xo5JgooCeqLcCofj6cE29taXEG4riQF1J
 5cp9IOWDfaDXPbQ==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

Allow fixed-partitions to be specified through a partitions
node.

Fixes the below dtbs_check warning:

arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: nand@0,0: Unevaluated properties are not allowed ('partitions' was unexpected)

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
index 115682fa81b7..c2143f943e7f 100644
--- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
@@ -61,6 +61,11 @@ properties:
       GPIO connection to R/B signal from NAND chip
     maxItems: 1
 
+  partitions:
+    type: object
+    description:
+      Node containing description of fixed partitions.
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: /schemas/mtd/partitions/partition.yaml

---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240830-gpmc-dtb-de2ce28acfb6

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


