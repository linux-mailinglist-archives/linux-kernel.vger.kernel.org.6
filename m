Return-Path: <linux-kernel+bounces-440679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C69EC2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8D616670D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3F20A5E9;
	Wed, 11 Dec 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeq82kkD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3AF1FE476;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886446; cv=none; b=YwHFUgJjd9u8ejUEIMQit9re/watVSZQBU+AXl9PsB7GDwaVdm2bt+yCSqIjTz+vElpQEDk2G6Zee+QEnO0pYA4WteGeePr9dIBws2S111gs0chO715k5QHUd12+s1A2jahLOjYhiWt7gMjvADmJpGDLn4H30LQCIIVHugI/fOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886446; c=relaxed/simple;
	bh=Kn7kBZdWBSytIpGNOCzLhypvD3A6745ktApqiYP/TtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYBN1I+KVeQ0dkQgThjU7iS31a8elmZVgnwSwoufU8IP8IOIf5dBuTi9UuhZRYynHLuobpvVj1+tuN2RI6i6RMW29mAlu3bi3fWcKf/qaTNDE23M2Mw+oLNfR0X9Gvjvy1XIMNrztc1qDIT4thyfgQOeC6FO019G8TPx5hfEed0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeq82kkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81689C4CEDF;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733886445;
	bh=Kn7kBZdWBSytIpGNOCzLhypvD3A6745ktApqiYP/TtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aeq82kkDM6DYP/+mi0BxEF2/I3UiPBHEfOtSAhTifiqAH754hp/cyNllPVMN6mYG3
	 SM8RnjDDGpIB+nUpi6jUXVABZlbiKd//yKK7OF7oNFV91Vn58dzue6x7ccsIC/+Osl
	 0gaFE84WZWl9ilCGyjoAQN3fpHPtHzU/GI1NW3QNKqpTsg2EJKVTBZR1js4W/p0x0C
	 UrlSwMZy9UmuleaWKHyY6EWL4OV7pQdb6RVa9PauzM17oXJQgDSehD7LCiA1CesTzi
	 5tvNk4z/CmJlJbhH+UnGUE5v6vuKaqHF7OKpQ2iC+Cw9ntamc9iEuvcPOjUG4FE74a
	 wzjAhE3gW0VUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6D5E77182;
	Wed, 11 Dec 2024 03:07:25 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 10 Dec 2024 19:07:07 -0800
Subject: [PATCH v2 1/3] dt-bindings: connector: Add pd-revision property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-get_rev_upstream-v2-1-d0094e52d48f@google.com>
References: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
In-Reply-To: <20241210-get_rev_upstream-v2-0-d0094e52d48f@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733886444; l=1976;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=B8pzC6JyPb6d6J2y5c3NtirTYdP4wbp3vA4FOkKh+8Y=;
 b=x6OZql4uZejwU/PoFmWILQjDk19x2cbxV0bPjxctWOr7XEGzX1u12+ILPURCy5+sFV7jj7vCv
 vnhoNyv95QGBZ0GGeB4+xHtcFQ0X6Qer+HaGrjl9y1qJDjVRGE2qCbM
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add pd-revision property definition, to specify the maximum Power
Delivery Revision and Version supported by the connector.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 7 +++++++
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 67700440e23b5b7ca0db2c395c8a455bcf650864..11e40d225b9f3a0d0aeea7bf764f1c00a719d615 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -293,6 +293,13 @@ properties:
       PD negotiation till BC1.2 detection completes.
     default: 0
 
+  pd-revision:
+    description: Specifies the maximum USB PD revision and version supported by
+      the connector. This property is specified in the following order;
+      <revision_major, revision_minor, version_major, version_minor>.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    maxItems: 4
+
 dependencies:
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 20b62228371bdedf2fe92767ffe443bec87babc5..350d39fbf2dcd4d99db07cb8f099467e6fc653ee 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -70,6 +70,7 @@ examples:
                                        PDO_FIXED_DUAL_ROLE)
                                        PDO_FIXED(9000, 2000, 0)>;
                 sink-bc12-completion-time-ms = <500>;
+                pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
             };
         };
     };

-- 
2.47.0.338.g60cca15819-goog



