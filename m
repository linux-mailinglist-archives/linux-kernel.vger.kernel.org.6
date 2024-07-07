Return-Path: <linux-kernel+bounces-243481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5418B9296C3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC751F21E86
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104CCD2E5;
	Sun,  7 Jul 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lIOVhAW+"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B579E0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331811; cv=none; b=FfRd9z6eDXqxo9j+J6mbz3CAnjvUPXu4i3AoRNgsw2vfshnBUbOb3hBGVcuRAIqUnGl572Fb/a1x5IKWbjVu8C5QzW0kGyMrbF1qIRdp+RZ12KXS4gbIu2QSEnKxMOzWqLIjpAddcKcXTczrmixPV8vtHzB8z5HIbiq8CH9UK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331811; c=relaxed/simple;
	bh=OZ6IfSHHRN95XSIF6OwiF3W1o8Ut2XRNgJaDOh3EMsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcJ1/6ldnLYeqJxp/0w05x1ZVlpznbfUZmyvcv3oxbY7nXNnx69nZpqAM33e6xt7yvAKVxS7QkBr4vMdb1ozNVzT/BXPZewIYFly9W1QsMHcuyDpF2LOZkOph6FZvYTCZ1GOFp56PUwSUs9fFQQMgH8kgRl+IfMD7xjHdTWwBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lIOVhAW+; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id QKkEsyOxChEtDQKkEs8JGj; Sun, 07 Jul 2024 07:47:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720331253;
	bh=8pSTgdZnyG0WLlJB7fRFIXGVRIVCBFFXYFkuJxWni6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lIOVhAW+drTQMVfkDzgXljERlaxfwUOHWEUbsUAQdlUAg4+Ox8JCoD6OD6WNqHu9v
	 F1k0nngx4C99rcgu3tGXM4m7qLPFua7HGlCqCfNBTkF+euLbbtuCl9t6IFlT/qrJo3
	 b7pUGDfSn8rrhadTEwd6umJlYgJupUXhrukZ1NuvKpLyRkvMwxdGFc5c9N/Fi5BRxi
	 44cFKv7OZGUs3Z3qfvnIcf2pGdbmOai/4FJ9m8LNw1PQwcbz4TLKqKq6AosD8ruEwO
	 3erHBv4gG/2l3A7518DvuS9TCnnJIj1//yon6mFbRlXJe8YlXaNir/OSR6vnu4Wx6z
	 Kvot4pAGhQ5zQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Jul 2024 07:47:33 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fchiby@baylibre.com,
	fparent@baylibre.com,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/3] soc: mediatek: pwrap: Constify some data and other improvements
Date: Sun,  7 Jul 2024 07:47:19 +0200
Message-ID: <cover.1720331018.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is motivated by patch 1. The 2 other patches are some
additionnal goodies spotted while looking at the code.

Patch 1 constifies struct pmic_wrapper_type to move some data to a
read-only section, in order to increase safety.

Patch 2 does the same for some int arrays. This helps move about 7 ko of
data to a read-only section. Not that bad!

Patch 3 simplifies code related to clk management. It also fixes an
issue if the driver is unloaded.

Christophe JAILLET (3):
  soc: mediatek: pwrap: Constify struct pmic_wrapper_type
  soc: mediatek: pwrap: Constify some struct int[]
  soc: mediatek: pwrap: Use devm_clk_bulk_get_all_enable()

 drivers/soc/mediatek/mtk-pmic-wrap.c | 118 +++++++--------------------
 1 file changed, 30 insertions(+), 88 deletions(-)

-- 
2.45.2


