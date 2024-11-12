Return-Path: <linux-kernel+bounces-406301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E789C5D07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4D61F2452A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F0204931;
	Tue, 12 Nov 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gasandoil.ci header.i=@gasandoil.ci header.b="U38f1Ho9"
Received: from web16.vename.ci (web16.vename.ci [51.15.161.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE67C204F7B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.15.161.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428448; cv=none; b=FN2X/KTOrObfBp30/NI9lrGyQd03+9sAerODo+4rND5cismVnCpXHUYoVY5HAny+ILfjmrV4qLE+pveiUDhMrlgL3l6h67pGOQ9lkopIqyz9jMoQkS9s9uwgPIEuP3BMenMSqJxzSmjGDDXDpP4xJDL13pUdZ/UVu6pyU6PVR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428448; c=relaxed/simple;
	bh=n2MeaoZ4BjNYcxcll7l+IZlQ652oJtZ2V4x49SX/X7w=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=CFNIRWRT57w2fczO6ZkirnAF+bgI10zKb+7l7eNuvXNywnFD8iUs0uoUBg1Iu2zn5HXSQGxCSKtanJeCGnbhTfe3iabPcdWyBaOAirIhmq8nkigsVRwUYIHjbfpnUeenwzuWquvwV5MyudaDOjkxfqD3kZKpeSnDF7nQK5Vbtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gasandoil.ci; spf=fail smtp.mailfrom=gasandoil.ci; dkim=pass (1024-bit key) header.d=gasandoil.ci header.i=@gasandoil.ci header.b=U38f1Ho9; arc=none smtp.client-ip=51.15.161.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gasandoil.ci
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gasandoil.ci
Received: by web16.vename.ci (Postfix, from userid 109)
	id 082ABA8C9A71; Tue, 12 Nov 2024 17:21:59 +0100 (CET)
Received: by web16.vename.ci (Postfix, from userid 10142)
	id D147BA934803; Tue, 12 Nov 2024 17:16:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gasandoil.ci;
	s=default; t=1731428211;
	bh=UvbXsgv0bp0wNNeTIlcG2RcOI+YkMP/UKpRMLXH1hE0=; h=To:Subject:From;
	b=U38f1Ho9lNI7iWTfnnppfZohCmgJW4+HzZHw+Wi+yc92s22xdCfk7Zi4PPKwV1JyR
	 iwcNuCNeCuCRnDaY6lc93Dzsa/eZ+U+6byQruDUfEO89ncPbYEAn9xZr160f1jubOV
	 0WMD2w5/e5l6Dj5ckrjCFWZRsmm2PdpWDgyhduuY=
To: linux-kernel@vger.kernel.org
Subject: EURO OIL  EN590 SALES AND TSA
Date: Tue, 12 Nov 2024 16:16:51 +0000
From: EURO OIL  SERVICE <support@gasandoil.ci>
Reply-To: info@eurooilservices.com
Message-ID: <4ea493b7eb14b00db852300e5baa105b@gasandoil.ci>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173142821175.3777.715843405323162066@web16.vename.ci>
X-PPP-Vhost: gasandoil.ci

Hello,
 
We Euro Oil Services Terminal is an independent tank terminal brokers   and  oil and  gas  sales trading  operator on CIF and FOB  bases with headquarter in latvia, providing a strong, reliable network of serving our customers' storage, distribution, and logistical needs. Our terminals of Operation ( Is Riga ,Houston, Jurong, Qingdao, Fujairah, Zhoushan and Rotterdam) store and handle petroleum products such as EN590, D6 Virgin LPFO, Jet Fuel JP54, WTI, Jet A-1, Diesel D2 and Fuel Oil.
 
We understand the need for safety and reliability, together with speed and flexibility to help our customers capitalize on opportunities. This makes us more than just a tank storage company.
 
For more storage enquiry and request for a Tank Storage Lease Agreement (TSA), and  for EN590 10 PPM  and JET  A1  product  sales  kindly reach us with the below contact details:
 
Jan Trnivick  pavel
JIRI  OSSENDORF
HEAD OF  FLEET AND  TERMINALLING  SERVICE
Sabiedrība ar ierobežotu atbildību "Euro Oil Services"
Limited liability company (SIA) LV69ZZZ40003608209
Legal address:Rīga, Audupes iela 15/17, LV-10O 
MOEZELWEG 75, 3198LS EUROPOORT ROTTERDAM, NETHERLANDS
storage@eurooilservices.com
info@eurooilservices.com
Telephone  371-28-210-353
 31 65 3629157


