Return-Path: <linux-kernel+bounces-307030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E496470A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0697280FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D591AD9DE;
	Thu, 29 Aug 2024 13:41:29 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B51A76B7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938889; cv=none; b=XZ9wPZjvyqN3tnADzm7mOhChXt4W75E8B9qz541ms3QD4SbcgNxu+TtWy4g8U38Mxf7tS60auGBck6MFS38dJSKKWIyaNQM5uyE4LDNTkt94bx13+gK8rfWCKV2wFdIflJnLhcgxS5gVuTUa+bIeQ+SQ4aaKATIjbC7ZO+xKd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938889; c=relaxed/simple;
	bh=j15g7+Zs11MXgNdFt9xjPzQq0JE/TjMvjYfFKO5EiIg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lCRelADxto/d0fle8X+GEvpNaZ8WjTJ+x6eQBgCtgmr7TYVfVAvdYF1XBZOZBMKHCtCkogowcz+A37pn33p9rPFC+6MscXSRb/zfiibW7ycb/hppcGFH/eNTJ8q15WdD+Z+erq2ruYgPiPXIqzibnrcr+ZKkRIMEjFKXrwZMzDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fbdf:b855:e99a:9ec0])
	by michel.telenet-ops.be with cmsmtp
	id 5phL2D00Q0Yrr4n06phL2C; Thu, 29 Aug 2024 15:41:24 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjfOn-001GR8-Oo;
	Thu, 29 Aug 2024 15:41:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjfOq-0002Uf-Dp;
	Thu, 29 Aug 2024 15:41:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Davis <afd@ti.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] docs: dt: Update overlay file extension
Date: Thu, 29 Aug 2024 15:41:18 +0200
Message-Id: <4661808d64fe4cb53ec3f291045f62256c7a7755.1724938789.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building DTB overlays from .dts files is no longer supported.
Update the documentation to reflect this.

Fixes: 81d362732bac05f6 ("kbuild: Disallow DTB overlays to built from .dts named source files")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
---
v2:
  - Add Acked-by, Reviewed-by.
---
 Documentation/devicetree/overlay-notes.rst           | 12 ++++++------
 .../translations/zh_CN/devicetree/overlay-notes.rst  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.rst b/Documentation/devicetree/overlay-notes.rst
index e139f22b363e9f36..35e79242af9a928d 100644
--- a/Documentation/devicetree/overlay-notes.rst
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -38,10 +38,10 @@ Lets take an example where we have a foo board with the following base tree::
 	};
     ---- foo.dts ---------------------------------------------------------------
 
-The overlay bar.dts,
+The overlay bar.dtso,
 ::
 
-    ---- bar.dts - overlay target location by label ----------------------------
+    ---- bar.dtso - overlay target location by label ---------------------------
 	/dts-v1/;
 	/plugin/;
 	&ocp {
@@ -51,7 +51,7 @@ The overlay bar.dts,
 			... /* various properties and child nodes */
 		};
 	};
-    ---- bar.dts ---------------------------------------------------------------
+    ---- bar.dtso --------------------------------------------------------------
 
 when loaded (and resolved as described in [1]) should result in foo+bar.dts::
 
@@ -88,9 +88,9 @@ in the base DT. In this case, the target path can be provided. The target
 location by label syntax is preferred because the overlay can be applied to
 any base DT containing the label, no matter where the label occurs in the DT.
 
-The above bar.dts example modified to use target path syntax is::
+The above bar.dtso example modified to use target path syntax is::
 
-    ---- bar.dts - overlay target location by explicit path --------------------
+    ---- bar.dtso - overlay target location by explicit path -------------------
 	/dts-v1/;
 	/plugin/;
 	&{/ocp} {
@@ -100,7 +100,7 @@ The above bar.dts example modified to use target path syntax is::
 			... /* various properties and child nodes */
 		}
 	};
-    ---- bar.dts ---------------------------------------------------------------
+    ---- bar.dtso --------------------------------------------------------------
 
 
 Overlay in-kernel API
diff --git a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
index 43e3c0bc5a9f8235..ba5edd05dc1e7fd2 100644
--- a/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
+++ b/Documentation/translations/zh_CN/devicetree/overlay-notes.rst
@@ -43,10 +43,10 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
 	};
     ---- foo.dts ---------------------------------------------------------------
 
-覆盖bar.dts,
+覆盖bar.dtso,
 ::
 
-    ---- bar.dts - 按标签覆盖目标位置 ----------------------------
+    ---- bar.dtso - 按标签覆盖目标位置 ---------------------------
 	/dts-v1/;
 	/插件/;
 	&ocp {
@@ -56,7 +56,7 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
 			... /* 各种属性和子节点 */
 		};
 	};
-    ---- bar.dts ---------------------------------------------------------------
+    ---- bar.dtso --------------------------------------------------------------
 
 当加载（并按照[1]中描述的方式解决）时，应该产生foo+bar.dts::
 
@@ -90,9 +90,9 @@ Documentation/devicetree/dynamic-resolution-notes.rst[1]的配套文档。
 DT中的适当位置。在这种情况下，可以提供目标路径。通过标签的目标位置的语法是比
 较好的，因为不管标签在DT中出现在哪里，覆盖都可以被应用到任何包含标签的基础DT上。
 
-上面的bar.dts例子被修改为使用目标路径语法，即为::
+上面的bar.dtso例子被修改为使用目标路径语法，即为::
 
-    ---- bar.dts - 通过明确的路径覆盖目标位置 --------------------
+    ---- bar.dtso - 通过明确的路径覆盖目标位置 -------------------
 	/dts-v1/;
 	/插件/;
 	&{/ocp} {
@@ -102,7 +102,7 @@ DT中的适当位置。在这种情况下，可以提供目标路径。通过标
 			... /* 各种外围设备和子节点 */
 		}
 	};
-    ---- bar.dts ---------------------------------------------------------------
+    ---- bar.dtso --------------------------------------------------------------
 
 
 内核中关于覆盖的API
-- 
2.34.1


