Return-Path: <linux-kernel+bounces-562882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E26A63432
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D77117126C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013EA171658;
	Sun, 16 Mar 2025 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aBjf7Bl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03756B81;
	Sun, 16 Mar 2025 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742105262; cv=none; b=AcggmEBuME1yljOxnquW3SvOHRmZWkBpFcsddcXkrj+kBurR198FzE6xOoQaplyyTP7HrWeRy1xVX602qy66369w3vPfwji652jH++3zlf1CzlZsS0a/Ddj4K/xdk1zmBPXcwyA2C5us4i6nBmjeCaP3sJZciLhsmHn+hBnHdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742105262; c=relaxed/simple;
	bh=cg8ZHAwzI1pGdmRt3oMiugzFT+wxmx52sW2J284t/3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2tYJIf8DtDBww/Ntsu+gYTZRZYSh1nh2SBGBPu2NECnDVLEnsOJoKT33D7sY2naxcThJGLWy0qCbtWAdWIzkZfypbux6Qyh+L2bgki8q51J7H3+d/qLIIMUTlktjbpZDOv67kNuID9Oi/UYexD2mrLhI9bZntvTmGlKq65YD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aBjf7Bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E69C4CEDD;
	Sun, 16 Mar 2025 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742105260;
	bh=cg8ZHAwzI1pGdmRt3oMiugzFT+wxmx52sW2J284t/3Y=;
	h=From:To:Cc:Subject:Date:From;
	b=0aBjf7Blb3xkJ1m5hiOQIp4DPvUYYXkTQ6yvY24yD913lblThJu8okgYdsHYVJGE/
	 YGNOJpyKK9qHwGkWK0fUW9XzFUo+2b49/DfrQB2BU9wpsyNOtAdWwTweesHgnvpRMo
	 6ZRcIDjUxJBX9vPpBaT43PRcxDvtWi7gaWz0F9OA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: driver core: mark Rafael and Danilo as co-maintainers
Date: Sun, 16 Mar 2025 07:07:35 +0100
Message-ID: <2025031634-playing-lark-95f9@gregkh>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 27
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cg8ZHAwzI1pGdmRt3oMiugzFT+wxmx52sW2J284t/3Y=; b=owGbwMvMwCRo6H6F97bub03G02pJDOnXspYxruY7cnhqrMifZ38dpI55F8yx2N9esdLi2ztOr hO/vt+70RHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQAT0ZFmmB/jsf97Jm+By4zT 6npi5hkfnridSgCK/tz0fVbcBfG9BhfspPs6eBYVbHAFAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In talking it over with Rafael and Danilo, it makes more sense for
everyone to be a maintainer here, to share the load where possible.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0427b32b3688..2f6e379547bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7101,8 +7101,8 @@ F:	include/linux/component.h
 
 DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-R:	"Rafael J. Wysocki" <rafael@kernel.org>
-R:	Danilo Krummrich <dakr@kernel.org>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
+M:	Danilo Krummrich <dakr@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 F:	Documentation/core-api/kobject.rst
-- 
2.48.1


