Return-Path: <linux-kernel+bounces-536342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C393CA47E67
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319671666D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007922FACE;
	Thu, 27 Feb 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9kRNb7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9722DF92;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661075; cv=none; b=PfjL5qOVmcWLApj9Cq/zr63uTMjrpBzCKP5EwwSQEzRM6QwDGrX8+RaOAcQQzsdK/tMtAeEQyDWFb4zr+8cMahAZOWP1nGDPvQOTHVZGH8F47xgKK5fOaoJU+X2/8wiE0+Dsz7y/x+3pdYGllj7mXxsm30MkU/I8G9zxhf9hC4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661075; c=relaxed/simple;
	bh=wpoico5zVDQ/RsR7kFVoL/EXypEPWiwqwez3Px9fwqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARNWBvc8gqMRTtgoAqqqHm/BfSNc1TQjv+/xdfVciH8g+dUuUndu3GebnH9YvLp4Qgz5FAQFfY2z37c+jL6gMMDfzpEkh7xeq/UhGiLAwGx9kbRKguXN4rcQo3SrEoVQi/Lxb55nzOVqM+LAgUiw6feLbc0jSUR4YML0XbRTdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9kRNb7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3383EC4CEE9;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661075;
	bh=wpoico5zVDQ/RsR7kFVoL/EXypEPWiwqwez3Px9fwqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q9kRNb7htPUZleay9VrmlmrarNYvnDG7a9za/uWOYIo3P6Q1KrTI6TpHry4xQmu6w
	 OsgNKKETpprGYJmZ+xcXomGkd2qHR+epL7H2qgjC9stiR9GHTw8cfcUi7iii0Yiwc3
	 hrhqoMfbbQu23qyKJmdGnmVw6cpSaNcqVVbKemkWZG08/lBerYwvbIHD5G7nU8C8NA
	 srUX1Mw0v29ugEdDS+mzdnT3KYgA7Cgzquh5cHGp9oM3EM75yNOhj3iZrnlJ0+/P7F
	 RJVyvw2bLmbvDuN4ahcB7zb3saoyd7jqs7SILLjzs92FnHoqpk6BCrMjGyvF+BNnw0
	 8ZP6gBn8UDETg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26327C19F32;
	Thu, 27 Feb 2025 12:57:55 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Thu, 27 Feb 2025 13:57:52 +0100
Subject: [PATCH 2/3] dt-bindings: hwmon: ntc-thermistor: fix typo regarding
 the deprecation of the ntc, compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-ntc_thermistor_fixes-v1-2-70fa73200b52@gocontroll.com>
References: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
In-Reply-To: <20250227-ntc_thermistor_fixes-v1-0-70fa73200b52@gocontroll.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Joseph McNally <jmcna06@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740661074; l=992;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=go8V0aZ/npOUYtcmaYuylqPFZ1dFM88LliPYDxQ4huM=;
 b=KL/bHOiQgKzvK+suFA2uzR6LNggkAGjIjfkm+a3DKhoW5sUgA/IEnZwnHpWGh4zVfJ3BGi7r5
 eHE5T4ug+OTCqo7oWlzCZbB2Ptvh3FmSSYzelyx6ygAklpkDjoV9rWz
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Fix the comment stating that the "ntp," compatible strings are deprecated
which should be "ntc,"

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
index 3d0146e20d3e10747c3049911b9419e9ccdab83d..b8e500e6cd9f861fbbabd79a14d882341dbb387c 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
@@ -76,7 +76,7 @@ properties:
       - const: murata,ncp03wf104
       - const: murata,ncp15xh103
       - const: samsung,1404-001221
-      # Deprecated "ntp," compatible strings
+      # Deprecated "ntc," compatible strings
       - const: ntc,ncp15wb473
         deprecated: true
       - const: ntc,ncp18wb473

-- 
2.48.1



