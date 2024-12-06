Return-Path: <linux-kernel+bounces-434552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7025F9E682C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BBE168E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06E1DF748;
	Fri,  6 Dec 2024 07:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4Tqnhd2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BF1DDC3F;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471218; cv=none; b=b4nObeImMkcctl1VhTMIW6hc6OIczFaKMA8O/p0cDc0IcURzeoPLtvzmOMB2YPoFAicd9NvYINgEMiDkno7eG0MoaaWy/SigBVmeTyWQW7SD/U2lfORWeUEzC73yimWmV6tyPstQcf0wxp8HB+KbZCMbadV6svM+MFEXEBC9MmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471218; c=relaxed/simple;
	bh=Q0eQs9S1ZtP3dTPRCecbQHN1HOTEtAG6/4CUFgxubHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5K0sP1WIgIMNWJ8T3dHX/UO+w/kx9abI9Xb2JBU4YKQPoGaj4ZI1wa02lFYCPvL88UAxGF6MVmxCinbf3SfreejBKrNILUWrIrJ3lwzUtXYuAwLCN2vv5HmZkziaqX/SOoyW1gYBmTKW688GZ4zy9wiGPtEJvK9/2L8A21a74o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4Tqnhd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C45CC4CEE0;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733471218;
	bh=Q0eQs9S1ZtP3dTPRCecbQHN1HOTEtAG6/4CUFgxubHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q4Tqnhd2vi/J5R/Rgc6Ix0D8D6F855NNH0kX/WLDsdkipxebG6cJvXhHEYhVGCmsN
	 B/PmGulrmVS2jHw00cZAT3IqjBd/kHTw9kBfHxHLuCu5YXII1RUut1fq6ROLC3xA46
	 5u6YfpNHVg35sQCoRfq58rzrAtChi+8XU7UbTp15QCso7adoq+23HXsusZd+qamINY
	 SbRM04yIMHCLvImn7Fhd6sQ4DZCRxI02AX3/i9wgbqGW/kWi6LplEdDEKQ7ewl4+lX
	 hPqLeU6M08trk8RfzUlQFs4ThtaKy3st7vQzf+7JCF+Nll1YDpeSXBiFC3hhbyRzK0
	 kAaRCnphGBQ1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B8E77179;
	Fri,  6 Dec 2024 07:46:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Thu, 05 Dec 2024 23:46:08 -0800
Subject: [PATCH 1/3] dt-bindings: connector: Add pd-revision property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>
References: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
In-Reply-To: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733471217; l=1957;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=KCmbTIYgv+x/jL3O6vDHgQvacNFdRGVm2+fsSGCWj+Y=;
 b=jKPvHiOi2wcPAm8xaOb259LiyLK7UT/7BuQMvOhx8IA0cMKZNgIm51ClNUs9rmjz50CQ7xG4R
 tlpJBr1FwDpBDP1ftV1lqliBLK/si3qmYxX8wNMmuMfAQyZllq3dKKK
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
 Documentation/devicetree/bindings/connector/usb-connector.yaml | 6 ++++++
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 67700440e23b5b7ca0db2c395c8a455bcf650864..341d2872e8d43450d219b7b72d48790051dc4e2b 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -293,6 +293,12 @@ properties:
       PD negotiation till BC1.2 detection completes.
     default: 0
 
+  pd-revision:
+    description: Specifies the maximum USB PD revision and version supported by
+      the connector. This property is specified in the following order;
+      <revision_major, revision_minor, version_major, version_minor>.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
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



