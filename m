Return-Path: <linux-kernel+bounces-223765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA239117EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99041F22E92
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B015D1;
	Fri, 21 Jun 2024 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jsvi.net header.i=contacto2@jsvi.net header.b="qj8DP/gf"
Received: from vps11.jsvi.net (vps11.jsvi.net [81.7.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A55A7E8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.6.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718932493; cv=none; b=bKnrPh+GEr2QqiUJbb24Jq1DFE0y4MGtAIaBgmmzxnFjb/AsUiW1PDLVjyQ2QOiJxLlw+AjyEQUTIphh2vykRqBhp3jyxCEUQvbK/ZuqIW1azPj0gwtIdyPrYwpCgRnbGe+ZnnoDDCLnZscqXanukV8+d4a/6gbm7UgXzzVjZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718932493; c=relaxed/simple;
	bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=tkcVtIPQJjczRwJKOVIjs+g4+rdJY/rxn1ElTKuYigzk3fVq/lDvbV4P6ZFeq+HCdxuq0yrhJNYS+wsdmlOTE4sr8rwaluCBQJtjAoRQxpsDnGI/sgmXkdWIp05xyZwADzdhN0vquMxOzTyozBWTIGegSN/xQLYg0UWN98FVcTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jsvi.net; spf=pass smtp.mailfrom=jsvi.net; dkim=pass (1024-bit key) header.d=jsvi.net header.i=contacto2@jsvi.net header.b=qj8DP/gf; arc=none smtp.client-ip=81.7.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jsvi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsvi.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=jsvi.net;
 h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=contacto2@jsvi.net;
 bh=LBwaLr+wlbr8N/ILBVAzTSG0uUZeAj3452+lutsr+lA=;
 b=qj8DP/gfpvamdMj7ItUahnsWE/Y2siLaBYbki3OiDZ/y/MiVJqprjK2yS8303TwfQyQUWdMDJu7e
   WIoVlVw+zoEtDouJJldq9bBrue7sqFK9soAiYLVxMg6f2kt4Tx+pp+HncAQBOuJXHM8I/E57AK6v
   oVzpTHd4bhwek/dpg2A=
Message-ID: <a5848328dcf1e8e3ca8f396d99411b1b04eb6ea0@jsvi.net>
From: Paty <contacto2@jsvi.net>
To: linux-kernel@vger.kernel.org
Subject: hola
Date: Thu, 20 Jun 2024 19:57:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1";
Content-Transfer-Encoding: quoted-printable

Saludos a todos

