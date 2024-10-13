Return-Path: <linux-kernel+bounces-362662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E484C99B7CD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 02:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEA11F2276F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF71862;
	Sun, 13 Oct 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purpod.org header.i=informes7@purpod.org header.b="mbDjp7YB"
Received: from vps11.purpod.org (vps11.purpod.org [81.7.4.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3013647
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.4.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728779612; cv=none; b=pF8O6VxdhKDhXlCUdDU0+28dWvidhRNNGSUrow/+tl3HXj+Swe4QTATNbS312JRY6LWlKqsk1JdqwBol3BQ32Tfbx0L/wNq6KcyD3sS5SMeW31PA4I3YCvm9Iuttwems8FOekg2Zpa9xWjzwRE/YLsKeeMMWSblMcV2ygF7pKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728779612; c=relaxed/simple;
	bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=ndwJPIiBMJWqml53AZYyQXlirWdd7EN9hTQsCezOe/fploD5QtWnK0I/7Jm3L++C17my7YCLoCMAdMiEGNCnzI7UTbACpKmfGHzLv5FT/ZaXHuieZoUwZn5xEKk+qRpbEhNy50VcmlyV8rLqIlI1X6OdH+UVnWNGQDd5CqfxpzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purpod.org; spf=fail smtp.mailfrom=purpod.org; dkim=pass (1024-bit key) header.d=purpod.org header.i=informes7@purpod.org header.b=mbDjp7YB; arc=none smtp.client-ip=81.7.4.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=purpod.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purpod.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=purpod.org;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=informes7@purpod.org;
 bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
 b=mbDjp7YB65jNyHF1SQOJGG+99VFFPH+flaPhHtqYE8hIBUAMOW/qn0IhUnIf5tcZfBCvBYUlUQPk
   DK9RMv0c6WvR6ZJHCogURmHgcEsQG+zVOpW7IKWBJC4m9keDM/Ba+0JieZhyPP1RTEzkBfr76Z8p
   h+qYibvRA0NHX+fqwHw=
Message-ID: <ae7b03b84c889589aa0a9cc8c30731ba920454d6b9@purpod.org>
From: Sarita <informes7@purpod.org>
To: linux-kernel@vger.kernel.org
Subject: hola
Date: Sat, 12 Oct 2024 19:18:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1";
Content-Transfer-Encoding: quoted-printable

Saludos a todos

